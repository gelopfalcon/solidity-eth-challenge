import React, { useEffect, useState } from "react";
import { useContractEvent } from "wagmi";
import Info from "../icons/Info";
import { getAddressShortcut } from "../utils";

const Banner = ({ contract }) => {
  const [eventData, setEventData] = useState(undefined);
  const [message, setMessage] = useState("");
  useContractEvent({
    ...contract,
    eventName: "eventNewPokemon",
    listener: event => {
      console.log(event);
      setEventData({ event: "eventNewPokemon", data: event });
    },
  });

  useContractEvent({
    ...contract,
    eventName: "eventPokemonTrained",
    listener: event => {
      console.log(event);
      setEventData({ event: "eventPokemonTrained", data: event });
    },
  });

  // let stars = "";
  // if ((eventData.event = "eventPokemonTrained" && eventData.data.length > 0)) {
  //   for (let i = 0; i < eventData?.data[3].toString(); i++) {
  //     stars.concat("⭐");
  //   }
  // }

  useEffect(() => {
    if (eventData) {
      console.log(eventData);
      eventData.event == "eventNewPokemon" &&
        setMessage(
          getAddressShortcut(eventData?.data[0]) +
            " has just minted " +
            eventData?.data[1] +
            " who is type [" +
            eventData?.data[4].toString() +
            "]" +
            " and weak to " +
            "[" +
            eventData?.data[5].toString() +
            "]"
        );
      eventData?.event == "eventPokemonTrained" &&
        setMessage(
          eventData?.data[1] +
            " who is owned by " +
            getAddressShortcut(eventData?.data[0]) +
            " has evolved to evolution " +
            +eventData?.data[3].toString() +
            " and has learn the skill " +
            eventData?.data[4]
        );
      setTimeout(() => {
        setEventData(undefined);
        setMessage("");
      }, 20000);
    }
  }, [eventData]);

  useEffect(() => {
    message && console.log(message);
  }, [message]);

  return (
    <>
      <div
        className={`w-full max-h-[16] py-3 bg-green-200 flex items-center justify-center transition-all duration-500 ${
          !message && "!max-h[0] !py-0"
        }`}
      >
        <div className="flex items-center justify-center">
          {message && <Info className="text-green-800 w-[24px] h-[24px] mr-1" />}
          <p className="relative bottom-[1px] font-medium text-base text-green-800">{message}</p>
        </div>
      </div>
    </>
  );
};

export default Banner;
