(function () {
  var App = React.createClass({
    render: function () {
      return (
        <div className='page'>
          <h1>json-api.rocks</h1>
          <MovieList endpoint='/api/movies'/>
        </div>
      );
    }
  });

  React.render(
    <App />,
    document.getElementById('content')
  );
})();
