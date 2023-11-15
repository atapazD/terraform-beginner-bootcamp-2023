document.getElementById('playButton').addEventListener('click', function() {
    // Play the audio
    var audio = document.getElementById('audio');
    audio.play();

    // Show the background container and start the fade-in transition
    var backgroundContainer = document.getElementById('background-container');
    backgroundContainer.style.display = 'block';
    backgroundContainer.style.opacity = 0;

    setTimeout(function() {
        backgroundContainer.style.opacity = 1;
    }, 100); // Start the fade-in after a slight delay
});
