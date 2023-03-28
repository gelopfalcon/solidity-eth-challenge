import React, { useEffect, useState } from "react";
import { useContractWrite, usePrepareContractWrite, useWaitForTransaction } from "wagmi";
import { Loading, Tooltip, css } from "@nextui-org/react";
import Error from "../icons/Error";


const Mint = ({ contract, onClose }) => {
  const [name, setName] = useState("");
  const [inputError, setInputError] = useState({ display: false, error: "" });
  const [firstInputRender, setFirstInputRender] = useState(true);

  // The contractNameArg will be set in the mintButton call, to evitate
  //  multiple usePrepareContractWrite when the user changes the name input
  // This is actually not working, because it says that mint() it's not defined.
  const [contractNameArg, setContractNameArg] = useState("");

  const { config } = usePrepareContractWrite({
    ...contract,
    functionName: "createPokemon",
    args: [name],
  });

  const {
    data: mintData,
    isError: isMintingError,
    error: mintingError,
    isLoading: isMintLoading,
    isSuccess: isMintStarted,
    write: mint,
  } = useContractWrite({
    ...config,
  });

  const {
    isSuccess: isTxSuccess,
    isLoading: isTxLoading,
    isError: isTxError,
    error: txError,
  } = useWaitForTransaction({
    hash: mintData?.hash,
  });

  useEffect(() => {
    firstInputRender && setFirstInputRender(false);
    setInputError({ display: false, error: "first render disable" });
    if (!firstInputRender) {
      if (name.length < 2) {
        setInputError({ display: true, error: "The name length must be > 2" });
      } else if (name.length > 12) {
        setInputError({ display: true, error: "The name length must be < 12" });
      } else if (name.length >= 2 && name.length <= 12) {
        setInputError({ display: false, error: "" });
        // !!mint
        //   ? setInputError({ display: false, error: "" })
        //   : setInputError({ display: true, error: "Unknown error. Try with other" });
      }
    }
  }, [name, mint]);

  useEffect(() => {
    if (isTxSuccess) {
      onClose();
    }
  }, [isTxSuccess]);

  const onMintPokemon = () => {
    console.log("trigering onMintPokemon");
    // Falta agregar debouncing al minting
    setContractNameArg(name);
    mint && mint();
  };

  return (
    <>
      <h3 className="text-white mb-5">Mint a new pokemon</h3>
      <span className="flex align-items text-white ">
        <label htmlFor="pokemonName" className="mr-2 text-lg">
          Name:
        </label>
        <span className="relative">
          <input
            id="pokemonName"
            type="text"
            className="text-white py-1 px-2 rounded-md bg-white/10 flex items-center justify-center"
            value={name}
            onChange={e => {
              setName(e.target.value);
            }}
          />
          {inputError.display && (
            <p className="text-red-600 text-sm absolute top-[2.2rem]">{inputError.error}</p>
          )}
        </span>
      </span>
      {/* mintData, isMintLoading, isMintStarted, isMintingError*/}
      {/* isTxSuccess, isTxLoading,  isTxError */}
      <Tooltip
        content={
          (isMintingError || isTxError) && (
            <span className="flex items-center">
              <Error className="w-5 h-5 mr-1 text-red-500" />
              <p className="text-red-500">
                {isMintingError ? mintingError.toString() : txError.toString()}
              </p>
            </span>
          )
        }
        placement="bottom"
        color="invert"
        rounded={false}
        className={"mt-8 !w-full"}
      >
        <button
          className="btn w-full h-10"
          disabled={inputError.error || isMintLoading || isTxLoading}
          onClick={() => {
            if (!inputError.error) {
              onMintPokemon();
            }
          }}
        >
          <p className="mr-2">
            {isMintLoading && "Waiting confirmation"}
            {isMintingError && "Transaction rejected. Try Again"}
            {isTxError && "Transaction error"}
            {isTxLoading && "Processing transaction"}
            {isTxSuccess && "Transaction success!"}

            {!isMintLoading &&
              !isMintingError &&
              !isTxLoading &&
              !isTxError &&
              !isTxSuccess &&
              "MINT POKEMON"}
          </p>

          {(isMintLoading || isTxLoading) && (
            <Loading size="sm" color="currentColor" textColor={"primary"} />
          )}
        </button>
      </Tooltip>
    </>
  );
};

export default Mint;
