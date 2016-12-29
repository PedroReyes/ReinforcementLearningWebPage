// =====================================================
// THE CANVAS
// =====================================================
var myCanvas;

// =====================================================
// CONNECTION BETWEEN R AND JAVASCRIPT
// =====================================================
var startGame, stoppedGame, parametersReceived, receivingAirAttack, gameIsFinished;
var newState;
var nextStates;

// =====================================================
// DRAWING THE GAME
// =====================================================
// Root of images
var rootOfImages = "master_thesis/images/tank/";
var zoneNames;
var zoneImages;

// Window size
var widthWindow = 500, heightWindow = widthWindow / 2;

var strokeW = 1;

var columns = 3, rows = columns, blockSizeX, blockSizeY, dir = 2;

// Agent's life
var agentLife = 100;
var agentLifePositionX, agentLifePositionY;
var agentFullLife;
var agentPosition;
var agentIsDead;
var sizeForAgentBarLife = 5;

// Agent's life
var enemyLife = 80;
var enemyLifePositionX, enemyLifePositionY;
var enemyFullLife;
var enemyIsDead;

// Map state (for drawing zones)
var mapState;//Map<Point, STATES> mapState;

// Auxiliary images
var imageBackground;
var imageEnemyTank;
var imageAgentTank;
var imageEndStateAgentDestroyed;
var imageEndStateEnemyDestroyed;

// Current state of the agent
var currentState; // State

// =====================================================
// SET UP
// =====================================================
function preload(){
    loadImages();
}

function setup() {
    // Canvas in the HTML page
    var idCanvas = 'divCanvas';

    // Size of the canvas
    var width = document.getElementById(idCanvas).clientWidth;
    var height = document.getElementById(idCanvas).clientHeight;
    div = 1.7;
    width = window.innerWidth/div;
    height = window.innerHeight/div;

    // Creating the canvas and set the place where to put it
    myCanvas = createCanvas(width, height);
    myCanvas.parent(idCanvas);

    // Connection variables among R and Javascript
    startGame = false;
    stoppedGame = true;
    agentIsDead = false;
    enemyIsDead = false;
    receivingAirAttack = false;
    newState = [0,0];

    // Background
    background(0);

    // Setup the initial map
    setupGame();

    // BACKGROUND
    imageBackground.resize(widthWindow, heightWindow);
    background(imageBackground); // 255

    // STOP UNTIL NEW INFORMATION ARRIVES
    noLoop();
}

function draw() {
    // BACKGROUND
    imageBackground.resize(widthWindow, heightWindow);
    background(imageBackground); // 255

    if(stoppedGame){
        // GAME STOPPED

    }else if(gameIsFinished){
        // DISPLAYING END STATE OF THE GAME
        drawingGameEndState();

    }else if(startGame && parametersReceived && !gameIsFinished){
        // DRAWING THE LINES
        drawingLines();

        // DRAWING ZONES
        drawingZones();

        // DRAWING THE ENEMY
        drawingEnemy();

        // DRAWING THE ENEMY LIFE
        drawingEnemyLife();

        // DRAWING THE AGENT
        drawingAgent();

        // DRAWING THE AGENT LIFE
        drawingAgentLife();

        // DRAWING AIR ATTACK, IF ANY
        drawingAirAttack();

        // DRAWING GREEDY PATH OF THE AGENT
        drawingGreedyPath();
    }
}

// =====================================================
// AUXILIARY FUNCTIONS FOR DRAWING GAME
// =====================================================
function setupGame(){
    // The game
    agentPosition = new Point(0, 0);

    widthWindow = width;
    heightWindow = height;

    agentLifePositionX = widthWindow - sizeForAgentBarLife;
    agentLifePositionY = heightWindow - sizeForAgentBarLife;

    enemyLifePositionX = sizeForAgentBarLife;
    enemyLifePositionY = heightWindow - sizeForAgentBarLife;

    blockSizeX = (widthWindow / columns);
    blockSizeY = (heightWindow / rows);
}

function loadImages(){
    // IMAGES (BACKGROUND, AGENT, AND ENEMY)
    imageBackground = loadImage(rootOfImages + "background.png");
    imageAgentTank = loadImage(rootOfImages + "agentTank.png");
    imageEnemyTank = loadImage(rootOfImages + "enemyTank.png");
    imageEndStateAgentDestroyed = loadImage(rootOfImages + "AGENTE_DESTRUIDO.png");
    imageEndStateEnemyDestroyed = loadImage(rootOfImages + "ENEMIGO_DESTRUIDO.png");

    // IMAGES (ZONES)
    zoneNames = {ZONA_REPARACION:"ZONA_REPARACION", ZONA_ATAQUE:"ZONA_ATAQUE", ZONA_EMBOSCADA:"ZONA_EMBOSCADA", ZONA_SEGURA:"ZONA_SEGURA", RECIBIENDO_ATAQUE_AEREO:"RECIBIENDO_ATAQUE_AEREO", ZONA_ANTIBOMBARDEOS:"ZONA_ANTIBOMBARDEOS"};

    zoneNames = ["ZONA_REPARACION", "ZONA_ATAQUE", "ZONA_EMBOSCADA", "ZONA_SEGURA", "RECIBIENDO_ATAQUE_AEREO", "ZONA_ANTIBOMBARDEOS"];

    zoneImages = Array(zoneNames.length);
    for(var i=0; i<zoneNames.length;i++){
        zoneImages[i] = loadImage(rootOfImages + zoneNames[i] + ".png");
    }
}


function drawingAirAttack(){
    if(receivingAirAttack){
        // Background
        ellipseMode(CORNER);

        ellipse(agentPosition.x * blockSizeX + (blockSizeX / (6.5)),
                agentPosition.y * blockSizeY + (blockSizeY / (6.5)), (blockSizeX / (1.5)),
                (blockSizeY / (1.5)));

        // Air attack symbol
        image(zoneImages[zoneNames.indexOf("RECIBIENDO_ATAQUE_AEREO")], 
              agentPosition.x * blockSizeX + (blockSizeX / 4),
              agentPosition.y * blockSizeY + (blockSizeY / 4), (blockSizeX / (2)),
              (blockSizeY / (2)));
    }
}

function drawingLines(){
    stroke(0);
    var i = 0;

    for (i = 0; i < columns; i++) {
        strokeWeight(strokeW);
        line(i * blockSizeX, 0, i * blockSizeX, height);
    }

    for (i = 0; i < rows; i++) {
        strokeWeight(strokeW);
        line(0, i * blockSizeY, width, i * blockSizeY);
    }
}

function drawingZones(){
    // DRAWING ZONES
    var i, j;
    if (mapState != null && mapState!=undefined) {
        for (i = 0; i < columns; i++) {
            for (j = 0; j < rows; j++) {
                if (mapState[i][j] != null && mapState!=undefined) {
                    image(zoneImages[zoneNames.indexOf(mapState[j][i])], i * blockSizeX, (rows - j - 1) * blockSizeY, blockSizeX, blockSizeY);
                }
            }
        }
    }
}

function drawingEnemy(){
    image(imageEnemyTank, (columns - 1) * blockSizeX, 0 * blockSizeY, blockSizeX, blockSizeY);

    // DRAWING THE LIFE OF THE AGENT (USING THE PERCENTAGE OF LIFE)
    // > setting the configuration of the bar
    stroke(255, 0, 0);
    strokeWeight(12);
    strokeCap(ROUND);

    // > drawing the line
    line(enemyLifePositionX, enemyLifePositionY, enemyLifePositionX,
         (int) (0 + heightWindow * (100 - enemyLife) / 100));

    // > coming back to the older configuration
    stroke(0);
    strokeWeight(1);
}

function drawingAgent(){
    // DRAWING THE AGENT
    image(imageAgentTank, agentPosition.x * blockSizeX, agentPosition.y * blockSizeY, blockSizeX, blockSizeY);

    // DRAWING THE LIFE OF THE AGENT (USING THE PERCENTAGE OF LIFE)
    // > setting the configuration of the bar
    stroke(0, 255, 0);
    strokeWeight(12);
    strokeCap(ROUND);

    // > drawing the line
    line(agentLifePositionX, agentLifePositionY, agentLifePositionX, (0 + heightWindow * (100 - agentLife) / 100));

    // > coming back to the older configuration
    stroke(0);
    strokeWeight(1);
}

function drawingAgentLife(){
    // DRAWING THE LIFE OF THE ENEMY TANK (USING THE PERCENTAGE OF LIFE)
    stroke(0, 255, 0);
    strokeWeight(12);
    strokeCap(ROUND);

    // > Drawing the life
    line(agentLifePositionX, agentLifePositionY, agentLifePositionX, (0 + heightWindow * (100 - (agentLife*100/agentFullLife)) / 100));
    stroke(0);
}

function drawingEnemyLife(){
    // DRAWING THE LIFE OF THE ENEMY TANK (USING THE PERCENTAGE OF LIFE)
    stroke(255, 0, 0);
    strokeWeight(12);
    strokeCap(ROUND);

    // > Drawing the life
    line(enemyLifePositionX, enemyLifePositionY, enemyLifePositionX,
         (0 + heightWindow * (100 - (enemyLife*100/enemyFullLife)) / 100));

    stroke(0);
}

function drawingGameEndState(){
    background(255)

    if(agentIsDead){
        image(imageEndStateAgentDestroyed, (widthWindow / 2) - blockSizeX/2, (heightWindow / 2) -blockSizeY/2, (blockSizeX), (blockSizeY));
    }else if(enemyIsDead){
        image(imageEndStateEnemyDestroyed, (widthWindow / 2) - blockSizeX/2, (heightWindow / 2) -blockSizeY/2, (blockSizeX), (blockSizeY));
    }
}

function drawingGreedyPath(){
    if (nextStates != null && nextStates!=undefined) {
        noFill();
        strokeWeight(4);
        stroke(0, 0, 255);

        // Printing the next greedy positions
        for (var i = 0; i < nextStates.length; i = i + 2) {
            var agentPosition = [nextStates[i], nextStates[i+1]];

            rect(agentPosition[0] * blockSizeX, (rows - agentPosition[1] - 1) * blockSizeY, blockSizeX, blockSizeY);
        }
    } else {
        print("no next states");
    }
}


// =====================================================
// AUXILIARY FUNCTIONS FOR GAME EXECUTION
// =====================================================

// =====================================================
// START GAME AND STOP GAME 
// =====================================================
$(document).on('shiny:inputchanged', function(event) {
    if (event.name === 'buttonExecuteGame' || event.name === 'buttonRepeatGame') {
        startGame = true;
        gameIsFinished = false;
        agentIsDead = false;
        enemyIsDead = false;
        stoppedGame = false;

        if(event.name === 'buttonRepeatGame'){
            parametersReceived = true;

            // Set up the map again
            setupGame();
        }else{
            parametersReceived = false;
        }
    }else if(event.name === 'buttonStopGame'){
        stoppedGame = true;
    }
});

// =====================================================
// RECEIVING MESSAGES OF TYPE "________" FROM THE SERVER
// =====================================================
Shiny.addCustomMessageHandler("parameters", function(message) {
    // New size of the map
    columns = parseInt(message);
    rows = columns;

    // Set up the map again
    setupGame();

    // Parameters received
    parametersReceived = true;
});

Shiny.addCustomMessageHandler("mapState", function(message) {
    mapState = message;
});

Shiny.addCustomMessageHandler("agentPosition", function(message) {
    var pos = message;
    agentPosition = new Point(pos[0], rows-pos[1]-1);

    // REDRAWING
    redraw();
}); 

Shiny.addCustomMessageHandler("receivingAirAttack", function(message) {
    receivingAirAttack = Boolean(message);
});

Shiny.addCustomMessageHandler("lifeState", function(message) {
    agentLife = message[0];
    enemyLife = message[1];

    // REDRAWING
    redraw();
});

Shiny.addCustomMessageHandler("fullLife", function(message) {
    agentFullLife = message[0];
    enemyFullLife = message[1];
});

Shiny.addCustomMessageHandler("agentIsDead", function(message) {
    agentIsDead = Boolean(message);
    
    console.log("agent is dead");
    console.log(message);

    if(gameIsFinished){
        gameIsFinished = gameIsFinished
    }else{
        gameIsFinished = agentIsDead;   
    }

    // REDRAWING
    redraw();
});

Shiny.addCustomMessageHandler("enemyIsDead", function(message) {
    enemyIsDead = Boolean(message);
    
    //console.log(string.concat("enemy is dead ", message));
    console.log("enemy is dead");
    console.log(message);

    if(gameIsFinished){
        gameIsFinished = gameIsFinished
    }else{
        gameIsFinished = enemyIsDead;   
    }

    // REDRAWING
    redraw();
});


Shiny.addCustomMessageHandler("nextGreedyPositions", function(message) {
    nextStates = Array(message.length);
    for(var i = 0; i<message.length;i++){
        nextStates[i] = message[i]
    }

    // REDRAWING
    redraw();
});
