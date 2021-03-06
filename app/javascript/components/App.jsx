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
        Beka's Birthday Party Pics!
      <Gallery
      photos={this.state.pics.map(pic => {
          return {
            src: pic.path,
            height: Math.floor(Math.random() * 3) + 2,
            width: Math.(Math.random() * 3) + 2
          }
      }
          ).reverse()
        } />
      </div>
    );
  }  
}

export default App;
