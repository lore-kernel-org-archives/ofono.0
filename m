Content-Type: multipart/mixed; boundary="===============5461570335966208450=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: Ofono CF states not always correct
Date: Tue, 11 Jan 2011 12:00:42 +0200
Message-ID: <4D2C2A4A.80604@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5461570335966208450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I have been trying out and going through the code concerning Call Forwardin=
g and I found out that if you enable for example CF VoiceBusy and then CF V=
oiceUnconditional, the VoiceBusy is still according to ofono enabled. This =
of course as such isn't so bad but by using org.ofono.SupplementaryServices=
 to query the CF states ofono gives different response i.e. now only the Vo=
iceUnconditional is enabled and then I can disable only the VoiceUnconditio=
nal by using the org.ofono.SupplementaryServices and when doing so I found =
out that now ofono thinks that no CF is enabled even though VoiceBusy is ac=
tually active.

Now to fix this there exists multiple solutions I believe, here's some that=
 I came up.
1:Ofono could send query to modem/network for all the CF values when ever v=
oice unconditional value is changed. The good side in this is that ofono wo=
uld definetly be up to date.

2:Have separate status value internally and change that accordingly. E.g<pr=
operty>  <number to>  <status>  and return<number to>  to client when<statu=
s>  =3D=3D 1. Change any conditional<status>  to 0 if unconditional<status>=
  =3D=3D 1 without touching the<number to>  field and when unconditional<st=
atus>  is changed to 0 change all conditional<status>  to 1 if respecting<n=
umber to>  exists. This would of course be much faster however I'm not sure=
 how tedious this would be to implement.

3:Whenever unconditional value is changed, empty the internal "CF cache" i.=
e. remove all the conditional values all together or set "cache flag" to 0 =
and thus forcing the query to be made to modem/network.This should be as go=
od as option 1 except the queries are made only when client needs it. Altho=
ugh the assumption is that client queries the properties after changing the=
m(otherwise the client remains in wrong state). So depending on how the cli=
ent's been implemented might result on system level to same behavior as opt=
ion 1.

As I said these are what quickly came to my mind so there might be other so=
lutions as well. So the reason for this posting is to raise discussion on w=
hat would be the correct way to fix this?

-Jarko-


--===============5461570335966208450==--

