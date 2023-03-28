import React from "react";
import { Tooltip } from "@nextui-org/react";
import Info from "../icons/Info";
import Emoji from "./Emoji";
import { MINS_COOLDOWN } from "../pages/_app";
import { getAddressShortcut } from "../utils";

const PokemonCard = ({ pokemon, index, owned }) => {
  const pokeColor = [];
  pokemon.color.forEach(color => {
    pokeColor.push(color.toNumber());
  });

  const pokeDropShadow = " drop-shadow(0 0 1px " + "rgb(" + pokeColor.toString() + ")" + ") ";
  const pokeColorClass =
    pokeDropShadow + pokeDropShadow + pokeDropShadow + pokeDropShadow + pokeDropShadow;

  let dateNow = new Date().getTime() / 1000;
  let trainingDiffMins = (dateNow - pokemon.lastTimeTrained) / 60;
  let trainingCooldown = trainingDiffMins >= MINS_COOLDOWN ? 0 : MINS_COOLDOWN - trainingDiffMins;
  return (
    <article
      key={index}
      className={`text-white bg-white/5  border-2 border-white/40 pt-3 pl-3 pr-4 pb-4 rounded-md flex drop-shadow-[0_0_5px_rgba(255,255,255,0.05)] shadow-[0_0_5px_rgba(255,255,255,0.3)] ${
        owned &&
        "bg-[rgba(34,197,94,0.1)] border-green-500/70 drop-shadow-[0_0_5px_rgba(50,255,50,0.05)] shadow-[0_0_5px_rgba(50,255,50,0.5)]"
      }`}
    >
      <div className="flex flex-col mr-3 w-[50%] items-center relative">
        <span className="flex items-center justify-between w-10/12 md:w-11/12 mb-[0.2rem]">
          {!owned && (
            <Tooltip
              content={
                <span className="flex items-center">
                  <Info className="w-5 h-5 mr-1" />
                  <p className="text-sm">
                    owned by 
                    <span className="text-sm"> {getAddressShortcut(pokemon.owner)}</span>
                  </p>
                </span>
              }
              placement="top"
              color="invert"
              rounded={false}
            >
              <p className="text-lg sm:text-base">{pokemon.name}</p>
            </Tooltip>
          )}
          {owned && <p className="text-lg sm:text-base">{pokemon.name}</p>}
          <p className="text-lg sm:text-sm text-gray-500 font-semibold ">N.º{pokemon.id}</p>
        </span>
        <img
          style={{ filter: pokeColorClass }}
          className={`w-full max-w-[120px] self-center image`}
          src="./pokemonBlack.png"
          alt="pokemon placeholder"
        />
      </div>
      <div className="w-[50%]">
        <p className="text-lg sm:text-base">Stats</p>
        <p className="sm:text-xs">
          Evolution:{" "}
          {Array.from(new Array(+pokemon.evolution.toString())).map((item, index) => (
            <Emoji
              symbol="⭐"
              label="star"
              className="text-[0.85rem]"
              key={index}
              amount={+pokemon.evolution.toString()}
            />
          ))}
        </p>
        <p className="sm:text-xs mt-0.5">Elements: {pokemon.elements.join(", ")}</p>
        <p className="sm:text-xs mt-0.5">Weaknesses: {pokemon.weaknesses.join(", ")}</p>
        <div className="mt-0.5">
          <p className="text-lg sm:text-base">Skills</p>
          <span>
            {pokemon.skills.map((skill, index) => {
              return (
                <span className="" key={index}>
                  <Tooltip
                    content={
                      <span className="flex items-center">
                        <Info className="w-5 h-5 mr-1" />
                        <p className="text-sm">{skill.description}</p>
                      </span>
                    }
                    placement="bottom"
                    color="invert"
                    rounded={false}
                  >
                    <p className="sm:text-xs">{skill.name}</p>
                  </Tooltip>
                </span>
              );
            })}
          </span>
        </div>
        {owned && (
          <p className="sm:text-xs text-gray-500 mt-0.5 italic">
            {trainingCooldown > 0
              ? "Training cd: " + Math.ceil(trainingCooldown) + " min"
              : "Ready to be trained"}
          </p>
        )}
      </div>
    </article>
  );
};

export default PokemonCard;
