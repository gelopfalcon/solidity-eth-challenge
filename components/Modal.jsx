import React, { useEffect, useState } from "react";

const Modal = ({ onClose, children }) => {
  return (
    <div
      className="fixed top-0 left-0 right-0 bottom-0 bg-black/50 flex items-center justify-center z-10"
      onClick={onClose}
    >
      <div
        className="w-[330px] h-[200px] rounded-lg z-20 bg-neutral-900 drop-shadow-[0_0_15px_rgba(0,0,0,0.7)] py-4 px-4 flex flex-col justify-between"
        onClick={e => {
          e.stopPropagation();
        }}
      >
        {children}
      </div>
    </div>
  );
};

export default Modal;
