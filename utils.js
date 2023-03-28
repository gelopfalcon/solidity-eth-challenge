export const getAddressShortcut = address => {
  return address.substring(0, 5) + "..." + address.substring(38, 42);
};
