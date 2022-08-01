import React from "react";

const PokemonContainer = ({ children, className }) => {
  return <div className={` ${className} gridContainer`}>{children}</div>;
};

export default PokemonContainer;
