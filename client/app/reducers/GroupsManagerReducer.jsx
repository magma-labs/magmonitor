const initialState = {
  value: ''
};

export default function groupsManagerReducer(state = initialState, action) {
  const { type, value } = action;
  switch (type) {
    case 'UPDATE_VALUE':
      return { value };
    default:
      return state;
  }
}
