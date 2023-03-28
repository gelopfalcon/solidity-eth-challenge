import React from "react";
const Emoji = (props) => {
  return (
    <span className="text-[1rem]">
      <span
        className={`emoji ${props.className}`}
        role="img"
        aria-label={props.label ? props.label : ""}
        aria-hidden={props.label ? "false" : "true"}
      >
        {props.symbol}
      </span>
    </span>
  );
};

export default Emoji;
