/*
 * Copyright (c) 2013, TheGhost
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright notice, this
 *       list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright notice, this
 *       list of conditions and the following disclaimer in the documentation and/or other
 *       materials provided with the distribution.
 *     * Neither the name of the product nor the names of its contributors may be used
 *       to endorse or promote products derived from this software without specific prior
 *       written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

const Red = 0xFF0000AA;
const Orange = 0xFF7F00AA;
const Yellow = 0xFFFF00AA;
const Green = 0x006400AA;
const Blue = 0x6495EDAA;
const Lightgreen = 0x33AA33AA;
const Gray = 0xAFAFAFAA;
const Lemon = 0xDDDD2357;
const Grayblue = 0x456EAF67;
const Darkred = 0xAA3333AA;

COLOR <- [
	0xFF0000AA, //0 - Red
	0xFF7F00AA, //1 - Orange
	0xFFFF00AA, //2 - Yellow
	0x006400AA, //3 - Green
	0x6495EDAA, //4 - Blue
	0x33AA33AA, //5 - Lightgreen
	0xDDDD2357, //6 - Lemon
	0xAA3333AA, //7 - Darkred
	0x456EAF67, //8 - Grayblue
	0xFF5F9EA0, //9 - Cadet Blue **TheGhost favorite
	0xFF008080, //10 - Teal **TheGhost favorite
	0xFF556B2F, //11 - Dark Olive Green **TheGhost favorite
	0xFF808000, //12 - Olive
	0xFF008B8B, //13 - Dark Cyan **TheGhost favorite
	0xFF800000  //14 - Marroon
];

const ID_PLAYER = 1;
const ID_HOUSE = 2;
const ID_USERGROUP = 3;
const ID_VEHICLE = 4;
const ID_PED = 5;
const ID_PICKUP = 6;
const ID_BLIP = 7;
const ID_CHECKPOINT = 8;
const ID_TIMER = 9;
const ID_SPAWNPOINT = 10;
const ID_OBJECT = 11;
const ID_ACCOUNT = 12;

const ID_GUEST = 1;
const ID_MEMBER = 2;
const ID_MODERATOR = 3;
const ID_ADMIN = 4;
const ID_LEADER = 5;

const ID_PLAYER_DEATH = 0;
const ID_PLAYER_CONNECT = 1;
const ID_PLAYER_MUTE = 2;
const ID_PLAYER_FROZE = 3;
const ID_PLAYER_DISCONNECT = 4;
const ID_ELEMENT_CREATE = 5;
const ID_ELEMENT_DATA_CHANGE = 6;
const ID_ELEMENT_DESTROY = 7;
const ID_SERVER_DATA_CHANGE = 8;
const ID_CLIENT_START = 9;

//local CHATBOX = true;
local math;