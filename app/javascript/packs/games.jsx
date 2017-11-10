// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import axios from 'axios';

class GamesComponent extends React.Component {
  constructor () {
    super();

    this.state = {
      games: []
    }
  }

  componentDidMount() {
    axios.get('/api/v1/games.json')
      .then(response => {
        this.setState({ games: response.data });
      })
      .catch(error => {
        console.error(error);
      });
  }

  gameResultText = (game) => {
    const gameFinished = (game.home_team_goals !== null) && (game.away_team_goals !== null);

    return gameFinished ? `${game.home_team_goals} : ${game.away_team_goals}` : '------';
  }

  renderGameRow = (game) => {
    const gameResultText = this.gameResultText(game);

    return(
      <tr key={game.id}>
        <td className="cell">{game.date}</td>
        <td className="cell">{game.home_team}</td>
        <td className="cell">{gameResultText}</td>
        <td className="cell">{game.away_team}</td>
      </tr>
    );
  }

  render() {
    return(
      <table>
        <thead>
          <tr>
            <th className="cell">Date</th>
            <th className="cell">Home Team</th>
            <th className="cell">Result</th>
            <th className="cell">Away Team</th>
          </tr>
        </thead>
        <tbody>
          {this.state.games.map((game) => this.renderGameRow(game))}
        </tbody>
      </table>
    )
  }
};


document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <GamesComponent />,
    document.body.appendChild(document.createElement('div')),
  )
})
