Content-Type: multipart/mixed; boundary="===============2978555779072815390=="
MIME-Version: 1.0
From: ext-arun.1.ravindran@nokia.com
Subject: doc: cdma-voicecall-manager-api.txt
Date: Fri, 26 Nov 2010 11:54:01 +0200
Message-ID: <1290765242-30673-1-git-send-email-ext-arun.1.ravindran@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2978555779072815390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

The CDMA voice call manager interface is missing the line identification an=
d start time property.
The MO and MT calls will have LineIdentification, which should be set to em=
pty when the call loses the LineIdentification. We will emit the property c=
hange whenever there is a flash sent.

Example cases:
1) Outgoing call to number "123"
    LineIdentification  =3D "123"
2) Incoming Call from Number "234"
    LineIdentification =3D "234"
3) a) Outgoing call to number "123"
    LineIdentification  =3D "123"
   b) Flash to number "345"
    LineIdentification  =3D ""
4) a) Incoming call from number "234"
    LineIdentification  =3D "234"
   b) Flash to number "345"
    LineIdentification  =3D ""
5) a) Outgoing call to number "123"
    LineIdentification  =3D "123"
   b) Flash with empty string
    LineIdentification  =3D ""
6) a) Incoming call from number "123"
    LineIdentification  =3D "123"
   b) Flash with empty string
    LineIdentification  =3D ""

Similarly for StartTime, for a normal outgoing and Incoming call, we have S=
tartTime values. But the issue is with Flash with String, where we cannot h=
ave the Call start time for the number which is sent as flash string. =

If a UI needs to show the call time for the flashed number, it cannot be de=
cided by oFono.

Example cases:
1) Outgoing call to number "123"
    StartTime  =3D xxxxx
2) Incoming call from number "123"
    StartTime  =3D xxxxx
3) a) Outgoing call to number "123"
    StartTime  =3D xxxxx
   b) Flash to number "234"
    No separate StartTime for "234" , and no property change emitted.
4) a) Incoming call from number "123"
    StartTime  =3D xxxxx
   b)  Flash to number "234"
    No separate StartTime for "234"  and no property change emitted.

We also need a SetProperty() API.

void SetProperty(string property, variant value)

                         Changes the value of the specified property. Only
                         properties that are listed as readwrite are
                         changeable. On success a PropertyChanged signal
                         will be emitted.

                         Possible Errors: [service].Error.InvalidArguments
                                          [service].Error.DoesNotExist

The following patch adds the above changes to document.

Regards
Arun

--===============2978555779072815390==--

