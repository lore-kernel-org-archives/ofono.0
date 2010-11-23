Content-Type: multipart/mixed; boundary="===============5601260774990438933=="
MIME-Version: 1.0
From: Simon LETHBRIDGE <simon.lethbridge@stericsson.com>
Subject: RE: [RFCv2] doc: Assisted Satellite Navigation API and Agent API
Date: Tue, 23 Nov 2010 16:07:26 +0100
Message-ID: <B4268AAFAFA3E244B5B0641D5914917048BCE1C099@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <AANLkTinO-T9Jig4GKNxiwtHVG8Yf-1prOnOiTJz4L5Jk@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5601260774990438933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrzej

> -----Original Message-----
> From: andrzej zaborowski [mailto:balrogg(a)gmail.com]


> =

> Since (correct me if I'm wrong) SendPositioningControl can only be
> called in response to PositioningRequest(), it would seem more logical
> to skip SendPositioningControl and have the agent return the xml
> string from PositioningRequest(), e.g.
> =

> string PositioningRequest(string xml_element)
> =

> A D-bus call can take a couple of minutes to respond if needed.
> =

There may be several calls to PositioningRequest() before a response is sen=
t.
The ofono agent would need to interpret the messages to see =

whether it should pend waiting for a response from the GNSS/GPS driver.  =

Once a positioning procedure has been started it may get aborted.  =

This abort may not be detected by the agent If the call
to the PositioningRequest() does not return.

Regards,

Simon

--===============5601260774990438933==--

