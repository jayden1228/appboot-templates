import React from 'react';
import { render } from '@testing-library/react';
import Home from '../home';
it('renders welcome message', () => {
    const { getByText } = render(<Home />);
    expect(getByText('Home')).toBeInTheDocument();
});
