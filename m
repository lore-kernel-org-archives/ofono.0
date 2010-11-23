Content-Type: multipart/mixed; boundary="===============8892994459239452886=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [RFCv2] doc: Assisted Satellite Navigation API and Agent API
Date: Tue, 23 Nov 2010 14:28:21 +0100
Message-ID: <AANLkTinO-T9Jig4GKNxiwtHVG8Yf-1prOnOiTJz4L5Jk@mail.gmail.com>
In-Reply-To: <1290438707-10896-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8892994459239452886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

2010/11/22 Sjur Br=C3=A6ndeland <sjurbren@gmail.com>:
> +Methods =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void Send=
PositioningControl(string xml_element)
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Send an XML element conforming to the XML DTD for <pos>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 as defined in 3GPP 27.007 Table 8.55-2. This xml is
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 used for transferring data associated with positioning
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 requests received via control plane from the network.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 This includes assistance data requests and the results
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 of positioning procedures. This method maps directly to
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 the 3GPP 27.007 AT+CPOS command.
...
> +PositioningRequestAgent hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unique na=
me
> +Interface =C2=A0 =C2=A0 =C2=A0org.ofono.PositioningRequestAgent
> +Object path =C2=A0 =C2=A0freely definable
> +
> +Methods =C2=A0 =C2=A0 =C2=A0 =C2=A0void PositioningRequest(string xml_el=
ement)
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Receive an XML element conforming to the XML DTD for
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <pos> in 3GPP 27.007. This xml is used for transferring
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 data associated with positioning requests received, via
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 control plane, from the network. This includes
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 measurement requests and assistance data. This method
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 maps directly to the 3GPP defined +CPOSR unsolicited
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 result code.

Since (correct me if I'm wrong) SendPositioningControl can only be
called in response to PositioningRequest(), it would seem more logical
to skip SendPositioningControl and have the agent return the xml
string from PositioningRequest(), e.g.

string PositioningRequest(string xml_element)

A D-bus call can take a couple of minutes to respond if needed.

Best regards

--===============8892994459239452886==--

