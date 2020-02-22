import React, { Component } from 'react';
import axios from 'axios'
import Gallery from "react-photo-gallery";
class App extends Component {
  constructor(props){
    super(props)
    this.state = {
      pics: []
    }
  }
  componentDidMount() {
    axios.get('/pics')
    .then(response => {
      console.log(response)
      this.setState({pics: response.data})
    })
    .catch(error => console.log(error))
  }


  render() {

    return (
      <div className="App">
      <Gallery
      photos={this.state.pics.map(pic => {
          return {
            src: pic.path
          }
      }
          )
        } />
      </div>
    );
  }  
}

export default App;
