#include <a_samp>
#include <sscanf2>
#include <streamer>
#include <zcmd>
#include <dof2>

#define DIALOG_EDITANDO 1
#define DIALOG_CRIAROBJETO 2
#define DIALOG_SELECIONAROBJETO 3
#define DIALOG_DESTRUIROBJETO 4
#define DIALOG_TEXTURIZAR1 5
#define DIALOG_TEXTURIZAR2 6
#define DIALOG_TEXTURIZAR3 7
#define DIALOG_TEXTURIZAR4 8
#define DIALOG_SALVAR 9
#define DIALOG_CARREGARMAPA 10
#define DIALOG_AJUDAED 11
#define DIALOG_COPIAROBJETO 12

new modelidc[MAX_PLAYERS];
new Float:xc[MAX_PLAYERS];
new Float:yc[MAX_PLAYERS];
new Float:zc[MAX_PLAYERS];
new Float:rxc[MAX_PLAYERS];
new Float:ryc[MAX_PLAYERS];
new Float:rzc[MAX_PLAYERS];


enum ObjetosInfo {
    bool:Editando,
	MaterialIndex,
	ModelID,
	TXDName[128],
	TextureName[256]
};

new Objetos[MAX_PLAYERS][ObjetosInfo];

enum E_OBJECT_DATA
{
	e_OWNER_ID,
	Text3D:e_LABEL_ID,
	MaterialIndex,
	ModelID,
	TXDName[256],
	TextureName[256]
};

new
	ObjetoData[MAX_OBJECTS][E_OBJECT_DATA] = { { INVALID_PLAYER_ID, Text3D:INVALID_3DTEXT_ID }, ... },
	ObjetoSelecionado[MAX_PLAYERS];

new PlayerText:ArrowText[MAX_PLAYERS][14];

#pragma warning disable 239

#define FILTERSCRIPT

main(){
	new id;
	while(++id < MAX_OBJECTS) {
		printf((IsValidObject(id) ? "Valido: %d" : "Invalido %d"), id);
	}
}

public OnFilterScriptInit()
{
	print("\n=.=.=.=.=.=.=.=.=.=.=.=.=.=");
	print("Gomaink's Map Editor v1.0");
	print("=.=.=.=.=.=.=.=.=.=.=.=.=.=\n");
	return 1;
}

public OnFilterScriptExit()
{
	DOF2_Exit();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetSpawnInfo(playerid, NO_TEAM, 1, 1693.2600,1453.8756,10.7642,268.7455, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnPlayerConnect(playerid)
{
	ArrowText[playerid][0] = CreatePlayerTextDraw(playerid, 122.000000, 322.000000, "X+");
	PlayerTextDrawFont(playerid, ArrowText[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][0], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][0], 149.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][0], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][0], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][0], 1);

	ArrowText[playerid][1] = CreatePlayerTextDraw(playerid, 122.000000, 353.000000, "X-");
	PlayerTextDrawFont(playerid, ArrowText[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][1], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][1], 149.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][1], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][1], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][1], 1);

	ArrowText[playerid][2] = CreatePlayerTextDraw(playerid, 154.000000, 322.000000, "Y+");
	PlayerTextDrawFont(playerid, ArrowText[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][2], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][2], 179.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][2], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][2], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][2], 1);

	ArrowText[playerid][3] = CreatePlayerTextDraw(playerid, 154.000000, 353.000000, "Y-");
	PlayerTextDrawFont(playerid, ArrowText[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][3], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][3], 179.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][3], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][3], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][3], 1);

	ArrowText[playerid][4] = CreatePlayerTextDraw(playerid, 184.000000, 322.000000, "Z+");
	PlayerTextDrawFont(playerid, ArrowText[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][4], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][4], 213.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][4], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][4], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][4], 1);

	ArrowText[playerid][5] = CreatePlayerTextDraw(playerid, 184.000000, 353.000000, "Z-");
	PlayerTextDrawFont(playerid, ArrowText[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][5], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][5], 214.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][5], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][5], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][5], 1);

	ArrowText[playerid][6] = CreatePlayerTextDraw(playerid, 122.000000, 322.000000, "RX+");
	PlayerTextDrawFont(playerid, ArrowText[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][6], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][6], 159.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][6], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][6], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][6], 1);

	ArrowText[playerid][7] = CreatePlayerTextDraw(playerid, 122.000000, 353.000000, "RX-");
	PlayerTextDrawFont(playerid, ArrowText[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][7], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][7], 159.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][7], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][7], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][7], 1);

	ArrowText[playerid][8] = CreatePlayerTextDraw(playerid, 163.000000, 322.000000, "RY+");
	PlayerTextDrawFont(playerid, ArrowText[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][8], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][8], 198.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][8], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][8], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][8], 1);

	ArrowText[playerid][9] = CreatePlayerTextDraw(playerid, 163.000000, 353.000000, "RY-");
	PlayerTextDrawFont(playerid, ArrowText[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][9], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][9], 198.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][9], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][9], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][9], 1);

	ArrowText[playerid][10] = CreatePlayerTextDraw(playerid, 202.000000, 322.000000, "RZ+");
	PlayerTextDrawFont(playerid, ArrowText[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][10], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][10], 238.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][10], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][10], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][10], 1);

	ArrowText[playerid][11] = CreatePlayerTextDraw(playerid, 202.000000, 353.000000, "RZ-");
	PlayerTextDrawFont(playerid, ArrowText[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][11], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][11], 238.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][11], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][11], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][11], 1);

	ArrowText[playerid][12] = CreatePlayerTextDraw(playerid, 122.000000, 384.000000, "ROTACAO");//RX
	PlayerTextDrawFont(playerid, ArrowText[playerid][12], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][12], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][12], 238.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][12], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][12], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][12], 1);

	ArrowText[playerid][13] = CreatePlayerTextDraw(playerid, 122.000000, 384.000000, "ROTACAO");//X
	PlayerTextDrawFont(playerid, ArrowText[playerid][13], 1);
	PlayerTextDrawLetterSize(playerid, ArrowText[playerid][13], 0.604165, 2.749999);
	PlayerTextDrawTextSize(playerid, ArrowText[playerid][13], 214.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ArrowText[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, ArrowText[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, ArrowText[playerid][13], 1);
	PlayerTextDrawColor(playerid, ArrowText[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, ArrowText[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, ArrowText[playerid][13], 150);
	PlayerTextDrawUseBox(playerid, ArrowText[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, ArrowText[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, ArrowText[playerid][13], 1);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	PlayerTextDrawDestroy(playerid, ArrowText[playerid][0]);
	PlayerTextDrawDestroy(playerid, ArrowText[playerid][1]);
	PlayerTextDrawDestroy(playerid, ArrowText[playerid][2]);
	PlayerTextDrawDestroy(playerid, ArrowText[playerid][3]);
	PlayerTextDrawDestroy(playerid, ArrowText[playerid][4]);
	PlayerTextDrawDestroy(playerid, ArrowText[playerid][5]);
	PlayerTextDrawDestroy(playerid, ArrowText[playerid][6]);
	PlayerTextDrawDestroy(playerid, ArrowText[playerid][7]);
	PlayerTextDrawDestroy(playerid, ArrowText[playerid][8]);
	PlayerTextDrawDestroy(playerid, ArrowText[playerid][9]);
	PlayerTextDrawDestroy(playerid, ArrowText[playerid][10]);
	PlayerTextDrawDestroy(playerid, ArrowText[playerid][11]);
	PlayerTextDrawDestroy(playerid, ArrowText[playerid][12]);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == ArrowText[playerid][0])//X+
    {
		new Float:x, Float:y, Float:z;
		GetObjectPos(ObjetoSelecionado[playerid], x, y, z);
		SetObjectPos(ObjetoSelecionado[playerid], x+0.1, y, z);
	}
	if(playertextid == ArrowText[playerid][1])//X-
    {
		new Float:x, Float:y, Float:z;
		GetObjectPos(ObjetoSelecionado[playerid], x, y, z);
		SetObjectPos(ObjetoSelecionado[playerid], x-0.1, y, z);
	}
	if(playertextid == ArrowText[playerid][2])//Y+
    {
		new Float:x, Float:y, Float:z;
		GetObjectPos(ObjetoSelecionado[playerid], x, y, z);
		SetObjectPos(ObjetoSelecionado[playerid], x, y+0.1, z);
	}
	if(playertextid == ArrowText[playerid][3])//Y-
    {
		new Float:x, Float:y, Float:z;
		GetObjectPos(ObjetoSelecionado[playerid], x, y, z);
		SetObjectPos(ObjetoSelecionado[playerid], x, y-0.1, z);
	}
	if(playertextid == ArrowText[playerid][4])//Z+
    {
		new Float:x, Float:y, Float:z;
		GetObjectPos(ObjetoSelecionado[playerid], x, y, z);
		SetObjectPos(ObjetoSelecionado[playerid], x, y, z+0.1);
	}
	if(playertextid == ArrowText[playerid][5])//Z-
    {
		new Float:x, Float:y, Float:z;
		GetObjectPos(ObjetoSelecionado[playerid], x, y, z);
		SetObjectPos(ObjetoSelecionado[playerid], x, y, z-0.1);
	}
	if(playertextid == ArrowText[playerid][6])//RX+
    {
		new Float:RotX,Float:RotY,Float:RotZ;
		GetObjectRot(ObjetoSelecionado[playerid], RotX, RotY, RotZ);
		SetObjectRot(ObjetoSelecionado[playerid], RotX+1.0, RotY, RotZ);
	}
	if(playertextid == ArrowText[playerid][7])//RX-
    {
		new Float:RotX,Float:RotY,Float:RotZ;
		GetObjectRot(ObjetoSelecionado[playerid], RotX, RotY, RotZ);
		SetObjectRot(ObjetoSelecionado[playerid], RotX-1.0, RotY, RotZ);
	}
	if(playertextid == ArrowText[playerid][8])//RY+
    {
		new Float:RotX,Float:RotY,Float:RotZ;
		GetObjectRot(ObjetoSelecionado[playerid], RotX, RotY, RotZ);
		SetObjectRot(ObjetoSelecionado[playerid], RotX, RotY+1.0, RotZ);
	}
	if(playertextid == ArrowText[playerid][9])//RY-
    {
		new Float:RotX,Float:RotY,Float:RotZ;
		GetObjectRot(ObjetoSelecionado[playerid], RotX, RotY, RotZ);
		SetObjectRot(ObjetoSelecionado[playerid], RotX, RotY-1.0, RotZ);
	}
	if(playertextid == ArrowText[playerid][10])//RZ+
    {
		new Float:RotX,Float:RotY,Float:RotZ;
		GetObjectRot(ObjetoSelecionado[playerid], RotX, RotY, RotZ);
		SetObjectRot(ObjetoSelecionado[playerid], RotX, RotY, RotZ+1.0);
	}
	if(playertextid == ArrowText[playerid][11])//RZ-
    {
		new Float:RotX,Float:RotY,Float:RotZ;
		GetObjectRot(ObjetoSelecionado[playerid], RotX, RotY, RotZ);
		SetObjectRot(ObjetoSelecionado[playerid], RotX, RotY, RotZ-1.0);
	}
	if(playertextid == ArrowText[playerid][13])//ROTACAORX
    {
		EsconderSetas(playerid);
		ExibirSetasR(playerid);
	}
	if(playertextid == ArrowText[playerid][12])//ROTACAOX
    {
		EsconderSetasR(playerid);
		ExibirSetas(playerid);
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_EDITANDO)
    {
        if(response) 
        {
            if(listitem == 0) 
            {
				ShowPlayerDialog(playerid, DIALOG_CRIAROBJETO, DIALOG_STYLE_INPUT, "Menu de Edicao", "Digite o ID do Objeto a ser criado:", "Aceitar", "Sair");
            }
            if(listitem == 1)
            {
				new strbox[1024] = "Objeto ID\n";

				for (new i = (MAX_OBJECTS - 1); i != -1; --i)
				{
					if (ObjetoData[i][e_OWNER_ID] == playerid)
					{
						new Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, modelid;
						format(strbox, sizeof(strbox), "ID: %s%d\n", strbox, i);
						modelid = GetObjectModel(i);
						GetObjectPos(i, x, y, z);
						GetObjectRot(i, rx, ry, rz);
						printf("CreateObject(%d, %f, %f, %f, %f, %f, %f, 300.0);\n",modelid,x,y,z,rx,ry,rz);
					}
				}

				if (strbox[11] == EOS)
					return SendClientMessage(playerid, -1, "{FF0000}Voce ainda nao criou nenhum objeto.");

				ShowPlayerDialog(playerid, DIALOG_SELECIONAROBJETO, DIALOG_STYLE_TABLIST_HEADERS, "Selecionar Objetos", strbox, "Aceitar", "Sair");
            }
			if(listitem == 2)
            {
				new strbox[1024] = "Objeto ID\n";

				for (new i = (MAX_OBJECTS - 1); i != -1; --i)
				{
					if (ObjetoData[i][e_OWNER_ID] == playerid)
					{
						new Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, modelid;
						format(strbox, sizeof(strbox), "ID: %s%d\n", strbox, i);
						modelid = GetObjectModel(i);
						GetObjectPos(i, x, y, z);
						GetObjectRot(i, rx, ry, rz);
						printf("CreateObject(%d, %f, %f, %f, %f, %f, %f, 300.0);\n",modelid,x,y,z,rx,ry,rz);

						modelidc[playerid] = modelid;
						xc[playerid] = x;
						yc[playerid] = y;
						zc[playerid] = z;
						rxc[playerid] = rx;
						ryc[playerid] = ry;
						rzc[playerid] = rz;
					} 
				}

				if (strbox[11] == EOS)
					return SendClientMessage(playerid, -1, "{FF0000}Voce ainda nao criou nenhum objeto.");

				ShowPlayerDialog(playerid, DIALOG_COPIAROBJETO, DIALOG_STYLE_TABLIST_HEADERS, "Selecionar Objetos", strbox, "Aceitar", "Sair");
            }
            if(listitem == 3)
            {
				EsconderSetas(playerid);
                ShowPlayerDialog(playerid, DIALOG_DESTRUIROBJETO, DIALOG_STYLE_INPUT, "Menu de Edicao", "Digite o ID do Objeto a ser destruido", "Aceitar", "Sair");
            }
			if(listitem == 4) 
			{
				ShowPlayerDialog(playerid, DIALOG_TEXTURIZAR1, DIALOG_STYLE_INPUT, "Menu de Edicao", "Digite o material index do objeto a ser texturizado (0 - 15):", "Aceitar", "Sair");
			}
			if(listitem == 5) 
			{
				ShowPlayerDialog(playerid, DIALOG_SALVAR, DIALOG_STYLE_INPUT, "Menu de Edicao", "Digite um nome para seu mapa (Recomendavel nao usar espaco):", "Aceitar", "Sair");
			}
			if(listitem == 6) 
			{
				ShowPlayerDialog(playerid, DIALOG_CARREGARMAPA, DIALOG_STYLE_INPUT, "Menu de Edicao", "Digite um nome de seu mapa:", "Aceitar", "Sair");
			}
        }
    }
	if(dialogid == DIALOG_SALVAR) 
	{
		if(response) 
		{
			new Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz;

			for (new i = (MAX_OBJECTS - 1); i != -1; --i)
			{
				if (ObjetoData[i][e_OWNER_ID] == playerid)
				{
					if(ObjetoData[i][TextureName] == 0)
					{
						new str[128], str2[128], str3[128], text[128];
						GetObjectPos(i, x, y, z);
						GetObjectRot(i, rx, ry, rz);

						format(str, sizeof(str), "%s.txt", inputtext);//formatando o arquivo

						if(!DOF2_FileExists(str)) DOF2_CreateFile(str);//verificando se nao existe e cria

						format(text, sizeof(text), "CreateObject(%d, %f, %f, %f, %f, %f, %f);", GetObjectModel(i), x, y, z, rx, ry, rz);//formatando o objeto
						format(str2, sizeof(str2), "Objeto[%04d]", i);//formatando o id do objeto para ser key
						DOF2_SetString(str, str2, text);
						DOF2_SaveFile();
						format(str3, sizeof(str3), "{4169E1}Mapa salvo com sucesso em scriptfiles/%s", str);
						SendClientMessage(playerid, -1, str3);
					}
					else if(ObjetoData[i][TextureName] != 0)
					{
						new str[128], str2[128], str3[128], text[128];
						GetObjectPos(i, x, y, z);
						GetObjectRot(i, rx, ry, rz);

						format(str, sizeof(str), "%s.txt", inputtext);//formatando o arquivo

						if(!DOF2_FileExists(str)) DOF2_CreateFile(str);//verificando se nao existe e cria

						format(text, sizeof(text), "CreateObject(%d, %f, %f, %f, %f, %f, %f);", GetObjectModel(i), x, y, z, rx, ry, rz);//formatando o objeto
						format(str2, sizeof(str2), "Objeto[%04d]", i);//formatando o id do objeto para ser key
						DOF2_SetString(str, str2, text);
						format(text, sizeof(text), "SetObjectMaterial(Objeto[%d], %d, %d, \"%s\", \"%s\", -1);", i, ObjetoData[i][MaterialIndex], ObjetoData[i][ModelID], ObjetoData[i][TXDName], ObjetoData[i][TextureName]);//formatando o objeto
						format(str2, sizeof(str2), "Material[%04d]", i);//formatando o id do objeto para ser key
						DOF2_SetString(str, str2, text);
						DOF2_SaveFile();
						format(str3, sizeof(str3), "{4169E1}Mapa salvo com sucesso em scriptfiles/%s", str);
						SendClientMessage(playerid, -1, str3);
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_TEXTURIZAR1) 
	{
		if(response) 
		{
			if(IsNumeric(inputtext)) 
			{
				if(strval(inputtext) >= 0 && strval(inputtext) <= 15)
				{
					Objetos[playerid][MaterialIndex] = strval(inputtext);
					ShowPlayerDialog(playerid, DIALOG_TEXTURIZAR2, DIALOG_STYLE_INPUT, "Menu de Edicao", "Digite o modelid da textura", "Aceitar", "Sair");
				}
			}
		}
	}
	if(dialogid == DIALOG_TEXTURIZAR2) 
	{
		if(response) 
		{
			if(IsNumeric(inputtext)) 
			{
				Objetos[playerid][ModelID] = strval(inputtext);
				ShowPlayerDialog(playerid, DIALOG_TEXTURIZAR3, DIALOG_STYLE_INPUT, "Menu de Edicao", "Digite o nome do txdname:", "Aceitar", "Sair");
			}
		}
	}
	if(dialogid == DIALOG_TEXTURIZAR3) 
	{
		if(response) 
		{
			new string[128];
			format(string, sizeof(string), "%s", inputtext);
			Objetos[playerid][TXDName] = string;
			ShowPlayerDialog(playerid, DIALOG_TEXTURIZAR4, DIALOG_STYLE_INPUT, "Menu de Edicao", "Digite o nome da texturename:", "Aceitar", "Sair");
		}
	}
	if(dialogid == DIALOG_TEXTURIZAR4) 
	{
		if(response)
		{
			new string[256];
			format(string, sizeof(string), "%s", inputtext);
			Objetos[playerid][TextureName] = string;
			SetObjectMaterial(ObjetoSelecionado[playerid], Objetos[playerid][MaterialIndex], Objetos[playerid][ModelID], Objetos[playerid][TXDName], Objetos[playerid][TextureName], 0xFFFFFFFF);
			
			ObjetoData[ObjetoSelecionado[playerid]][MaterialIndex] = Objetos[playerid][MaterialIndex];
			ObjetoData[ObjetoSelecionado[playerid]][ModelID] = Objetos[playerid][ModelID];

			format(string, sizeof(string), "%s", Objetos[playerid][TXDName]);
			ObjetoData[ObjetoSelecionado[playerid]][TXDName] = string;
			ObjetoData[ObjetoSelecionado[playerid]][TextureName] = string;
			SendClientMessage(playerid, -1, "{4169E1}Objeto texturizado com sucesso.");
		}
	}
	if(dialogid == DIALOG_DESTRUIROBJETO)
	{
		if(response)

		{
			if(IsNumeric(inputtext))
			{
				new objectid = strval(inputtext);
				
				if (!(0 <= objectid < MAX_OBJECTS))
					return SendClientMessage(playerid, -1, "{FF0000}ID de objeto invalido.");
				
				if (ObjetoData[objectid][e_OWNER_ID] == INVALID_PLAYER_ID)
					return SendClientMessage(playerid, -1, "{FF0000}Este objeto nao foi criado.");
				
				new ownerid = ObjetoData[objectid][e_OWNER_ID];

				if(ObjetoSelecionado[ownerid] == objectid)
				{
					StopEdit(ownerid);
					SendClientMessage(ownerid, -1, "{FF0000}O objeto que voce esta editando foi deletado.");
				}
				
				Delete3DTextLabel(ObjetoData[objectid][e_LABEL_ID]);
				DestroyObject(objectid);

				ObjetoData[objectid][e_OWNER_ID] = INVALID_PLAYER_ID;
				ObjetoData[objectid][e_LABEL_ID] = Text3D:INVALID_3DTEXT_ID;

				SendClientMessage(playerid, -1, "{4169E1}Objeto deletado com sucesso.");
			}
		}
	}
	if(dialogid == DIALOG_CRIAROBJETO)
	{
		if(response)
		{
			if(IsNumeric(inputtext))
			{			
				new Float:x, Float:y,  Float:z;
				GetPlayerPos(playerid, x, y, z);
				new objectid = CreateObject(strval(inputtext), x, y,z, 0.0, 0.0, 90.0);

				if (objectid == INVALID_OBJECT_ID)
					return SendClientMessage(playerid, -1, "{FF0000}Nao foi possivel criar este objeto.");


				ObjetoData[objectid][e_OWNER_ID] = playerid;

				new str[64];

				format(str, sizeof(str), "Objeto ID: {00FA9A}%d", objectid);
				ObjetoData[objectid][e_LABEL_ID] = Create3DTextLabel(str, -1, x, y, z, 5.0, GetPlayerVirtualWorld(playerid));

				SendClientMessage(playerid, -1, "{4169E1}Objeto criado com sucesso, use as setas para movimentar.");
				ExibirSetas(playerid);
				StartEdit(playerid, objectid);
			}
		}
	}
	if(dialogid == DIALOG_SELECIONAROBJETO)
	{
		if(response)
		{	
			new
				objectid = strval(inputtext),
				str[64];

			format(str, sizeof(str), "{4169E1}Objeto %d selecionado com sucesso, use as setas para movimentar.", objectid);
			SendClientMessage(playerid, -1, str);
			ExibirSetas(playerid);
			StartEdit(playerid, objectid);
		}
	}
	if(dialogid == DIALOG_COPIAROBJETO)
	{
		if(response)
		{
			new objectid = CreateObject(modelidc[playerid], xc[playerid], yc[playerid],zc[playerid], rxc[playerid], ryc[playerid], rzc[playerid]);

			if (objectid == INVALID_OBJECT_ID)
				return SendClientMessage(playerid, -1, "{FF0000}Nao foi possivel criar este objeto.");


			ObjetoData[objectid][e_OWNER_ID] = playerid;

			new str[64];

			format(str, sizeof(str), "Objeto ID: {00FA9A}%d", objectid);
			ObjetoData[objectid][e_LABEL_ID] = Create3DTextLabel(str, -1, xc[playerid], yc[playerid],zc[playerid], 5.0, GetPlayerVirtualWorld(playerid));

			SendClientMessage(playerid, -1, "{4169E1}Objeto copiado com sucesso, use as setas para movimentar.");
			ExibirSetas(playerid);
			StartEdit(playerid, objectid);
		}
	}
	if(dialogid == DIALOG_CARREGARMAPA) 
	{
		new str[64];
		format(str, sizeof(str), "%s.txt", inputtext);

		new File:handle = fopen(str, io_read), buf[128];
		if(handle) {
			new objetos[MAX_OBJECTS], id;
			while(fread(handle, buf)) {
				if(strfind(buf, "CreateObject")) {
					objetos[++id] = STR_CreateObject(playerid, buf);
				}

				if(strfind(buf, "SetObjectMaterial")) {
					STR_SetObjectMaterial(buf, objetos[id++]);
				}
			}
			format(str, sizeof(str), "{4169E1}Mapa %s carregado com sucesso.", str);
			SendClientMessage(playerid, -1, str);
			fclose(handle);
		}
	}
	return 1;
}

CMD:ajudaeditor(playerid) 
{
	ShowPlayerDialog(playerid, DIALOG_AJUDAED, DIALOG_STYLE_MSGBOX, "Ajuda Editor", "/editar - Menu de edicao.\n/veh - Criar um veiculo.\n/ajudaeditor - Abre esta dialog.", "Aceitar", "Sair");
	return 1;
}

CMD:editar(playerid)
{
    if(Objetos[playerid][Editando] == false)
    {
		EsconderSetas(playerid);
		EsconderSetasR(playerid);
        ShowPlayerDialog(playerid, DIALOG_EDITANDO, DIALOG_STYLE_LIST, "Menu de Edicao", "Criar Objeto\nSelecionar Objeto\nCopiar Objeto\nRemover Objeto\nTexturizar Objeto\nSalvar Mapa\nCarregar Mapa", "Aceitar", "Sair");
    }
    return 1;
}


CMD:veh(playerid, params[]) 
{
	new vehid;
	if(sscanf(params, "d", vehid)) return SendClientMessage(playerid, -1, "/vehid [vehicleid]");
	if(vehid != INVALID_VEHICLE_ID)
	{
		new Float:x, Float:y, Float:z, Float:a;
		GetPlayerFacingAngle(playerid,a);
		GetPlayerPos(playerid, x, y ,z);
		new idveh = CreateVehicle(vehid, x, y, z,a, 0, 0, -1);
		PutPlayerInVehicle(playerid, idveh, 0);
	}
	return 1;
}

stock IsNumeric(const string[])
{
    for (new i = 0, j = strlen(string); i < j; i++)
    {
        if (string[i] > '9' || string[i] < '0') return 0;
    }
    return 1;
}

stock ExibirSetas(playerid) 
{
	PlayerTextDrawShow(playerid, ArrowText[playerid][0]);
	PlayerTextDrawShow(playerid, ArrowText[playerid][1]);
	PlayerTextDrawShow(playerid, ArrowText[playerid][2]);
	PlayerTextDrawShow(playerid, ArrowText[playerid][3]);
	PlayerTextDrawShow(playerid, ArrowText[playerid][4]);
	PlayerTextDrawShow(playerid, ArrowText[playerid][5]);
	PlayerTextDrawShow(playerid, ArrowText[playerid][13]);
	SelectTextDraw(playerid, 0xFF0000FF);
	return 1;
}

stock ExibirSetasR(playerid) 
{
	PlayerTextDrawShow(playerid, ArrowText[playerid][6]);
	PlayerTextDrawShow(playerid, ArrowText[playerid][7]);
	PlayerTextDrawShow(playerid, ArrowText[playerid][8]);
	PlayerTextDrawShow(playerid, ArrowText[playerid][9]);
	PlayerTextDrawShow(playerid, ArrowText[playerid][10]);
	PlayerTextDrawShow(playerid, ArrowText[playerid][11]);
	PlayerTextDrawShow(playerid, ArrowText[playerid][12]);
	SelectTextDraw(playerid, 0xFF0000FF);
	return 1;
}

stock EsconderSetas(playerid) 
{
	PlayerTextDrawHide(playerid, ArrowText[playerid][0]);
	PlayerTextDrawHide(playerid, ArrowText[playerid][1]);
	PlayerTextDrawHide(playerid, ArrowText[playerid][2]);
	PlayerTextDrawHide(playerid, ArrowText[playerid][3]);
	PlayerTextDrawHide(playerid, ArrowText[playerid][4]);
	PlayerTextDrawHide(playerid, ArrowText[playerid][5]);
	PlayerTextDrawHide(playerid, ArrowText[playerid][13]);
	CancelSelectTextDraw(playerid);
	return 1;
}

stock EsconderSetasR(playerid) 
{
	PlayerTextDrawHide(playerid, ArrowText[playerid][6]);
	PlayerTextDrawHide(playerid, ArrowText[playerid][7]);
	PlayerTextDrawHide(playerid, ArrowText[playerid][8]);
	PlayerTextDrawHide(playerid, ArrowText[playerid][9]);
	PlayerTextDrawHide(playerid, ArrowText[playerid][10]);
	PlayerTextDrawHide(playerid, ArrowText[playerid][11]);
	PlayerTextDrawHide(playerid, ArrowText[playerid][12]);
	CancelSelectTextDraw(playerid);
	return 1;
}

forward TIMER_EditObject(playerid);
public TIMER_EditObject(playerid)
{
	if (ObjetoSelecionado[playerid] == INVALID_OBJECT_ID)
	{
		StopEdit(playerid);
		return 1;
	}

	new selected_obj = ObjetoSelecionado[playerid];

	if (ObjetoData[selected_obj][e_OWNER_ID] == INVALID_PLAYER_ID)
	{
		StopEdit(playerid);
		return 1;
	}

	new Float:x, Float:y, Float:z;

	GetObjectPos(selected_obj, x, y, z);
	
	Delete3DTextLabel(ObjetoData[selected_obj][e_LABEL_ID]);

	new str[64];
	format(str, sizeof(str), "Objeto ID: {00FA9A}%d", selected_obj);
	ObjetoData[selected_obj][e_LABEL_ID] = Create3DTextLabel(str, -1, x, y, z, 5.0, GetPlayerVirtualWorld(playerid));
	return 1;
}

StartEdit(playerid, objectid)
{
	StopEdit(playerid);

	ObjetoSelecionado[playerid] = objectid;

	SetPVarInt(playerid, "timer_obj_edit", SetTimerEx("TIMER_EditObject", 100, true, "i", playerid));
	return 1;
}

StopEdit(playerid)
{
	KillTimer(GetPVarInt(playerid, "timer_obj_edit"));
	DeletePVar(playerid, "timer_obj_edit");

	ObjetoSelecionado[playerid] = INVALID_OBJECT_ID;
	return 1;
}

stock fcreate(filename[])
{
    if (fexist(filename)){return false;}
    new File:fhandle = fopen(filename,io_write);
    fclose(fhandle);
    return true;
}

stock STR_CreateObject(playerid, string[]) {
	new
		objectid, source[128], model,
		Float:px, Float:py, Float:pz,
		Float:rx, Float:ry, Float:rz
	;
	ExtractFloat(source, string);
	if(!sscanf(source, "p<,>dffffff", model, px, py, pz, rx, ry, rz)) {
		objectid = CreateObject(model, px, py, pz, rx, ry, rz);
		ObjetoData[objectid][e_OWNER_ID] = playerid;
		new str[64];
		format(str, sizeof(str), "Objeto ID: {00FA9A}%d", objectid);
		ObjetoData[objectid][e_LABEL_ID] = Create3DTextLabel(str, -1, px, py, pz, 5.0, GetPlayerVirtualWorld(playerid));
	}
	return objectid;
}

stock ExtractFloat(dest[], source[]) {
	for(new a, b; a < strlen(source); a++) {
		switch(source[a]) {
			case 44, 46: dest[b++] = source[a];
			case 48..57: dest[b++] = source[a];
			default: continue;
		}
	}
}

stock STR_SetObjectMaterial(string[], objectid) {
	new dest[128], str[256], end = strfind(string, ");");
	strmid(dest, string, 48, (end - 1));
	for(new i; i < strlen(dest); i++) {
		if(dest[i] == ' ') strdel(dest, i, i);
	}
	new index, model, txdname[16], texture[16], color;
	sscanf(dest, "p<,>dds[16]s[16]d", index, model, txdname, texture, color);

	ObjetoData[objectid][MaterialIndex] = index;
	ObjetoData[objectid][ModelID] = model;

	format(str, sizeof(str), "%s", txdname);
	ObjetoData[objectid][TXDName] = str;
	format(str, sizeof(str), "%s", texture);
	ObjetoData[objectid][TextureName] = str;

	return SetObjectMaterial(objectid, index, model, txdname, texture, color);
}
