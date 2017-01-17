<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:fun="https://github.com/togiberlin/xml_lab"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- XSLT transformator for the Kalah Mancala game -->
    
    <xsl:output method="html" encoding="UTF-8"/>
    
    <!-- Variables for the positioning of the houses -->
    <xsl:variable name="xPosHouse" select="number(18.75)"/>
    <xsl:variable name="yPosHouse1" select="number(17.5)"/>
    <xsl:variable name="yPosHouse2" select="number(52.5)"/>
    <xsl:variable name="xOffsetHouses" select="number(12.5)"/>
    
    <!-- Variables for the sizing of the houses -->
    <xsl:variable name="rHouse" select="number(7)"/>
    
    <!-- Variables for the positioning of the stores -->
    <xsl:variable name="xPosStore1" select="number(7)"/>
    <xsl:variable name="xPosStore2" select="number(93)"/>
    <xsl:variable name="yPosStore" select="number(35)"/>
    
    <!-- Variables for the sizing of the stores -->
    <xsl:variable name="rxStore" select="number(5.5)"/>
    <xsl:variable name="ryStore" select="number(29)"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Kalah Mancala</title>
                
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
                
                <!-- Custom style -->
                <link rel="stylesheet" href="gameScreenStyle.css" type='text/css'/>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="mancalaGame">
        <!-- Variables -->
        <xsl:variable name="turnOfPlayerOne" select="turnOfPlayerOne"/>
        <xsl:variable name="gameOver" select="gameOver"/>
        
        <svg xmlns="http://www.w3.org/2000/svg"
            width="100%" height="100%">
            
            <desc>The GUI playground for the Kalah Mancala game</desc>
            
            <!-- Define common elements -->
            <defs>
                <!-- Red glow, that marks the players turn -->
                <filter id="glow">
                    <feColorMatrix type="matrix" values=
                        "0 0 0 1 0
                        0 0 0 0 0
                        0 0 0 0 0
                        0 0 0 1 0"/>
                    <feGaussianBlur stdDeviation="6" result="coloredBlur"/>
                    <feMerge>
                        <feMergeNode in="coloredBlur"/>
                        <feMergeNode in="SourceGraphic"/>
                    </feMerge>
                </filter>
                
                <!-- The background image for the field -->
                <pattern id="background" x="0" y="0" width="1" height="1">
                    <image width="100%" xlink:href="woodPattern.jpg"/>
                </pattern>
                
                <!-- Test whose turn it is and apply the glow -->
                <xsl:choose>
                    <xsl:when test="$turnOfPlayerOne = 0">
                        <!-- Store player 1 -->
                        <ellipse id="store-p1-template" rx="{$rxStore}%" ry="{$ryStore}%" stroke-width="5"/>
                        <!-- Store player 2 -->
                        <ellipse id="store-p2-template" rx="{$rxStore}%" ry="{$ryStore}%" stroke-width="5" style="filter:url(#glow)"/>
                        
                        <!-- House player 1 -->
                        <circle id="house-p1-template" cx="{$xPosHouse}%" cy="{$yPosHouse1}%" r="{$rHouse}%" stroke="orange" stroke-width="5" fill="lightyellow"/>
                        <!-- House player 2 -->
                        <circle id="house-p2-template" cx="{$xPosHouse}%" cy="{$yPosHouse2}%" r="{$rHouse}%" stroke="blue" stroke-width="5" style="filter:url(#glow)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- Store player 1 -->
                        <ellipse id="store-p1-template" rx="{$rxStore}%" ry="{$ryStore}%" stroke-width="5" style="filter:url(#glow)"/>
                        <!-- Store player 2 -->
                        <ellipse id="store-p2-template" rx="{$rxStore}%" ry="{$ryStore}%" stroke-width="5"/>
                        
                        <!-- House player 1 -->
                        <circle id="house-p1-template" cx="{$xPosHouse}%" cy="{$yPosHouse1}%" r="{$rHouse}%" stroke="orange" stroke-width="5" style="filter:url(#glow)"/>
                        <!-- House player 2 -->
                        <circle id="house-p2-template" cx="{$xPosHouse}%" cy="{$yPosHouse2}%" r="{$rHouse}%" stroke="blue" stroke-width="5" fill="lightblue"/>
                    </xsl:otherwise>
                </xsl:choose>
                
                <!-- Button -->
                <rect id="button" y="32%" rx="20" ry="20" width="15%" height="6%" stroke="green" stroke-width="5"/>
                <!-- Seed -->
                <circle id="seed" r="1%" fill="black"/>
            </defs>
            
            <!-- Background -->
            <svg>
                <rect rx="20" ry="20" width="100%" height="70%" fill="url(#background)" stroke="black" stroke-width="5"/>
            </svg>
            
            <!-- Check if the game is over yet and display the corresponding screen -->
            <xsl:choose>
                <xsl:when test="$gameOver = 0">
                    <!-- The game is not over -->
                    <svg>
                        <text x="50%" y="37%" font-size="50" font-weight="bold" fill="lightgreen" text-anchor="middle" >MANCALA</text>
                    </svg>
                    <a href="http://localhost:8984/gxf/newGame">
                        <g>
                            <use id="btn-menu" xlink:href="#button" x="22.5%" fill="lightgreen"/>
                            <text id="btn-menu-text" x="30%" y="36%" font-size="20" font-family="arial" fill="darkgreen" text-anchor="middle" >NEW GAME</text>
                        </g>
                    </a>
                    <a href="">
                        <g>
                            <use id="btn-menu" xlink:href="#button" x="62.5%" fill="lightgreen"/>
                            <text id="btn-menu-text" x="70%" y="36%" font-size="20" font-family="arial" fill="darkgreen" text-anchor="middle" >HELP</text>
                        </g>
                    </a>
                    
                    <xsl:apply-templates/>
                    
                </xsl:when>
                <xsl:otherwise>
                    <!-- The game is over, display the results -->
                    <xsl:variable name="store1NumOfSeeds" select="player1/store1/numOfSeeds"/>
                    <xsl:variable name="store2NumOfSeeds" select="player2/store2/numOfSeeds"/>
                    
                    <!-- Check who the winner is -->
                    <xsl:choose>
                        <xsl:when test="$store1NumOfSeeds &lt; $store2NumOfSeeds">
                            <svg>
                                <text x="50%" y="37%" font-size="50" fill="red" text-anchor="middle" >Awesome! Congratulations yellow player!</text>
                            </svg>
                        </xsl:when>
                        <xsl:when test="$store1NumOfSeeds = $store2NumOfSeeds">
                            <svg>
                                <text x="50%" y="37%" font-size="50" fill="red" text-anchor="middle" >Unbelievable! It's a tie!</text>
                            </svg>
                        </xsl:when>
                        <xsl:otherwise>
                            <svg>
                                <text x="50%" y="37%" font-size="50" fill="red" text-anchor="middle" >Awesome! Congratulations blue player!</text>
                            </svg>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </svg>
    </xsl:template>
    
    <!-- Players -->
    <xsl:template match="player1">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="player2">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Stores -->
    <xsl:template match="store1">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <use id="store-p1" xlink:href="#store-p1-template" x="{$xPosStore1}%" y="{$yPosStore}%" stroke="orange" fill="lightyellow" />
        <xsl:sequence select="fun:initSeeds($numOfSeeds,$xPosStore1,$yPosStore)"/>
    </xsl:template>
    <xsl:template match="store2">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <use id="store-p2" xlink:href="#store-p2-template" x="{$xPosStore2}%" y="{$yPosStore}%" stroke="blue" fill="lightblue" />
        <xsl:sequence select="fun:initSeeds($numOfSeeds,$xPosStore2,$yPosStore)"/>
    </xsl:template>
    
    <!-- Houses of player 1 -->
    <xsl:template match="house1">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="house11">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <xsl:variable name="turnOfPlayerOne" select="//turnOfPlayerOne"/>
        <!-- Test if the house should be displayed as a link, which triggers a REST call -->
        <xsl:choose>
            <xsl:when test="$turnOfPlayerOne = 1">
                <xsl:variable name="gameId" select="//mancalaGame/@id"/>
                <a href="http://localhost:8984/gxf/move/{$gameId}/house11">
                    <svg>
                        <use id="house-p1-1" class="house1-hover" xlink:href="#house-p1-template" fill="lightyellow"/>
                    </svg>
                    <xsl:sequence select="fun:initSeeds($numOfSeeds,$xPosHouse,$yPosHouse1)"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <use id="house-p1-1" xlink:href="#house-p1-template"/>
                <xsl:sequence select="fun:initSeeds($numOfSeeds,$xPosHouse,$yPosHouse1)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="house12">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <xsl:variable name="turnOfPlayerOne" select="//turnOfPlayerOne"/>
        <!-- Test if the house should be displayed as a link, which triggers a REST call -->
        <xsl:choose>
            <xsl:when test="$turnOfPlayerOne = 1">
                <xsl:variable name="gameId" select="//mancalaGame/@id"/>
                <a href="http://localhost:8984/gxf/move/{$gameId}/house12">
                    <svg>
                        <use id="house-p1-2" class="house1-hover" xlink:href="#house-p1-template" x="{$xOffsetHouses}%" fill="lightyellow"/>
                    </svg>
                    <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $xOffsetHouses),$yPosHouse1)"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <use id="house-p1-2" xlink:href="#house-p1-template" x="{$xOffsetHouses}%"/>
                <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $xOffsetHouses),$yPosHouse1)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="house13">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <xsl:variable name="turnOfPlayerOne" select="//turnOfPlayerOne"/>
        <xsl:variable name="offset" select="$xOffsetHouses * 2"/>
        <!-- Test if the house should be displayed as a link, which triggers a REST call -->
        <xsl:choose>
            <xsl:when test="$turnOfPlayerOne = 1">
                <xsl:variable name="gameId" select="//mancalaGame/@id"/>
                <a href="http://localhost:8984/gxf/move/{$gameId}/house13">
                    <svg>
                        <use id="house-p1-3" class="house1-hover" xlink:href="#house-p1-template" x="{$offset}%" fill="lightyellow"/>
                    </svg>
                    <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse1)"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <use id="house-p1-3" xlink:href="#house-p1-template" x="{$offset}%"/>
                <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse1)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="house14">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <xsl:variable name="turnOfPlayerOne" select="//turnOfPlayerOne"/>
        <xsl:variable name="offset" select="$xOffsetHouses * 3"/>
        <!-- Test if the house should be displayed as a link, which triggers a REST call -->
        <xsl:choose>
            <xsl:when test="$turnOfPlayerOne = 1">
                <xsl:variable name="gameId" select="//mancalaGame/@id"/>
                <a href="http://localhost:8984/gxf/move/{$gameId}/house14">
                    <svg>
                        <use id="house-p1-4" class="house1-hover" xlink:href="#house-p1-template" x="{$offset}%" fill="lightyellow"/>
                    </svg>
                    <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse1)"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <use id="house-p1-4" xlink:href="#house-p1-template" x="{$offset}%"/>
                <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse1)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="house15">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <xsl:variable name="turnOfPlayerOne" select="//turnOfPlayerOne"/>
        <xsl:variable name="offset" select="$xOffsetHouses * 4"/>
        <!-- Test if the house should be displayed as a link, which triggers a REST call -->
        <xsl:choose>
            <xsl:when test="$turnOfPlayerOne = 1">
                <xsl:variable name="gameId" select="//mancalaGame/@id"/>
                <a href="http://localhost:8984/gxf/move/{$gameId}/house15">
                    <svg>
                        <use id="house-p1-5" class="house1-hover" xlink:href="#house-p1-template" x="{$offset}%" fill="lightyellow"/>
                    </svg>
                    <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse1)"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <use id="house-p1-5" xlink:href="#house-p1-template" x="{$offset}%"/>
                <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse1)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="house16">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <xsl:variable name="turnOfPlayerOne" select="//turnOfPlayerOne"/>
        <xsl:variable name="offset" select="$xOffsetHouses * 5"/>
        <!-- Test if the house should be displayed as a link, which triggers a REST call -->
        <xsl:choose>
            <xsl:when test="$turnOfPlayerOne = 1">
                <xsl:variable name="gameId" select="//mancalaGame/@id"/>
                <a href="http://localhost:8984/gxf/move/{$gameId}/house16">
                    <svg>
                        <use id="house-p1-6" class="house1-hover" xlink:href="#house-p1-template" x="{$offset}%" fill="lightyellow"/>
                    </svg>
                    <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse1)"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <use id="house-p1-6" xlink:href="#house-p1-template" x="{$offset}%"/>
                <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse1)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Houses of player 2 -->
    <xsl:template match="house2">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="house21">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <xsl:variable name="turnOfPlayerOne" select="//turnOfPlayerOne"/>
        <!-- Test if the house should be displayed as a link, which triggers a REST call -->
        <xsl:choose>
            <xsl:when test="$turnOfPlayerOne = 0">
                <xsl:variable name="gameId" select="//mancalaGame/@id"/>
                <a href="http://localhost:8984/gxf/move/{$gameId}/house21">
                    <svg>
                        <use id="house-p2-1" class="house2-hover" xlink:href="#house-p2-template" fill="lightblue"/>
                    </svg>
                    <xsl:sequence select="fun:initSeeds($numOfSeeds,$xPosHouse,$yPosHouse2)" />
                </a>
            </xsl:when>
            <xsl:otherwise>
                <use id="house-p2-1" xlink:href="#house-p2-template"/>
                <xsl:sequence select="fun:initSeeds($numOfSeeds,$xPosHouse,$yPosHouse2)" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="house22">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <xsl:variable name="turnOfPlayerOne" select="//turnOfPlayerOne"/>
        <!-- Test if the house should be displayed as a link, which triggers a REST call -->
        <xsl:choose>
            <xsl:when test="$turnOfPlayerOne = 0">
                <xsl:variable name="gameId" select="//mancalaGame/@id"/>
                <a href="http://localhost:8984/gxf/move/{$gameId}/house22">
                    <svg>
                        <use id="house-p2-2" class="house2-hover" xlink:href="#house-p2-template" x="{$xOffsetHouses}%" fill="lightblue"/>
                    </svg>
                    <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $xOffsetHouses),$yPosHouse2)"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <use id="house-p2-2" xlink:href="#house-p2-template" x="{$xOffsetHouses}%"/>
                <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $xOffsetHouses),$yPosHouse2)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="house23">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <xsl:variable name="turnOfPlayerOne" select="//turnOfPlayerOne"/>
        <xsl:variable name="offset" select="$xOffsetHouses * 2"/>
        <!-- Test if the house should be displayed as a link, which triggers a REST call -->
        <xsl:choose>
            <xsl:when test="$turnOfPlayerOne = 0">
                <xsl:variable name="gameId" select="//mancalaGame/@id"/>
                <a href="http://localhost:8984/gxf/move/{$gameId}/house23">
                    <svg>
                        <use id="house-p2-3" class="house2-hover" xlink:href="#house-p2-template" x="{$offset}%" fill="lightblue"/>
                    </svg>
                    <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse2)"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <use id="house-p2-3" xlink:href="#house-p2-template" x="{$offset}%"/>
                <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse2)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="house24">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <xsl:variable name="turnOfPlayerOne" select="//turnOfPlayerOne"/>
        <xsl:variable name="offset" select="$xOffsetHouses * 3"/>
        <!-- Test if the house should be displayed as a link, which triggers a REST call -->
        <xsl:choose>
            <xsl:when test="$turnOfPlayerOne = 0">
                <xsl:variable name="gameId" select="//mancalaGame/@id"/>
                <a href="http://localhost:8984/gxf/move/{$gameId}/house24">
                    <svg>
                        <use id="house-p2-4" class="house2-hover" xlink:href="#house-p2-template" x="{$offset}%" fill="lightblue"/>
                    </svg>
                    <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse2)"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <use id="house-p2-4" xlink:href="#house-p2-template" x="{$offset}%"/>
                <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse2)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="house25">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <xsl:variable name="turnOfPlayerOne" select="//turnOfPlayerOne"/>
        <xsl:variable name="offset" select="$xOffsetHouses * 4"/>
        <!-- Test if the house should be displayed as a link, which triggers a REST call -->
        <xsl:choose>
            <xsl:when test="$turnOfPlayerOne = 0">
                <xsl:variable name="gameId" select="//mancalaGame/@id"/>
                <a href="http://localhost:8984/gxf/move/{$gameId}/house25">
                    <svg>
                        <use id="house-p2-5" class="house2-hover" xlink:href="#house-p2-template" x="{$offset}%" fill="lightblue"/>
                    </svg>
                    <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse2)"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <use id="house-p2-5" xlink:href="#house-p2-template" x="{$offset}%"/>
                <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse2)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="house26">
        <xsl:variable name="numOfSeeds" select="numOfSeeds"/>
        <xsl:variable name="turnOfPlayerOne" select="//turnOfPlayerOne"/>
        <xsl:variable name="offset" select="$xOffsetHouses * 5"/>
        <!-- Test if the house should be displayed as a link, which triggers a REST call -->
        <xsl:choose>
            <xsl:when test="$turnOfPlayerOne = 0">
                <xsl:variable name="gameId" select="//mancalaGame/@id"/>
                <a href="http://localhost:8984/gxf/move/{$gameId}/house26">
                    <svg>
                        <use id="house-p2-6" class="house2-hover" xlink:href="#house-p2-template" x="{$offset}%" fill="lightblue"/>
                    </svg>
                    <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse2)"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <use id="house-p2-6" xlink:href="#house-p2-template" x="{$offset}%"/>
                <xsl:sequence select="fun:initSeeds($numOfSeeds,($xPosHouse + $offset),$yPosHouse2)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Get the corresponding representation of the seeds -->
    <xsl:function name="fun:initSeeds">
        <xsl:param name="numOfSeeds"/>
        <xsl:param name="xPos"/>
        <xsl:param name="yPos"/>
        <xsl:choose>
            <xsl:when test="$numOfSeeds = 0"/>
            <xsl:when test="$numOfSeeds = 1">
                <use x="{$xPos}%" y="{$yPos}%" xlink:href="#seed"/>
            </xsl:when>
            <xsl:when test="$numOfSeeds = 2">
                <use x="{$xPos - 2}%" y="{$yPos}%" xlink:href="#seed"/>
                <use x="{$xPos + 2}%" y="{$yPos}%" xlink:href="#seed"/>
            </xsl:when>
            <xsl:when test="$numOfSeeds = 3">
                <use x="{$xPos - 2}%" y="{$yPos - 3}%" xlink:href="#seed"/>
                <use x="{$xPos}%" y="{$yPos}%" xlink:href="#seed"/>
                <use x="{$xPos + 2}%" y="{$yPos + 3}%" xlink:href="#seed"/>
            </xsl:when>
            <xsl:when test="$numOfSeeds = 4">
                <use x="{$xPos - 2}%" y="{$yPos + 3.5}%" xlink:href="#seed"/>
                <use x="{$xPos + 2}%" y="{$yPos + 3.5}%" xlink:href="#seed"/>
                <use x="{$xPos - 2}%" y="{$yPos - 3.5}%" xlink:href="#seed"/>
                <use x="{$xPos + 2}%" y="{$yPos - 3.5}%" xlink:href="#seed"/>
            </xsl:when>
            <xsl:when test="$numOfSeeds = 5">
                <use x="{$xPos - 2}%" y="{$yPos + 3.5}%" xlink:href="#seed"/>
                <use x="{$xPos + 2}%" y="{$yPos + 3.5}%" xlink:href="#seed"/>
                <use x="{$xPos}%" y="{$yPos}%" xlink:href="#seed"/>
                <use x="{$xPos - 2}%" y="{$yPos - 3.5}%" xlink:href="#seed"/>
                <use x="{$xPos + 2}%" y="{$yPos - 3.5}%" xlink:href="#seed"/>
            </xsl:when>
            <xsl:when test="$numOfSeeds = 6">
                <use x="{$xPos - 2}%" y="{$yPos + 4.5}%" xlink:href="#seed"/>
                <use x="{$xPos + 2}%" y="{$yPos + 4.5}%" xlink:href="#seed"/>
                <use x="{$xPos - 2}%" y="{$yPos}%" xlink:href="#seed"/>
                <use x="{$xPos + 2}%" y="{$yPos}%" xlink:href="#seed"/>
                <use x="{$xPos - 2}%" y="{$yPos - 4.5}%" xlink:href="#seed"/>
                <use x="{$xPos + 2}%" y="{$yPos - 4.5}%" xlink:href="#seed"/>
            </xsl:when>
            <xsl:otherwise>
                <text x="{$xPos}%" y="{$yPos + 1.5}%" font-size="50" fill="red" text-anchor="middle" ><xsl:value-of select="$numOfSeeds"/></text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
</xsl:stylesheet>