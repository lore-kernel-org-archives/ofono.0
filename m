Content-Type: multipart/mixed; boundary="===============1789655335066143292=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: ofono plugin
Date: Fri, 04 Nov 2011 13:40:26 +0100
Message-ID: <4EB3DD3A.9040408@monom.org>
In-Reply-To: <4EB2A567.7040105@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1789655335066143292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

an update on this one. We had yesterday a long discussion again on
#ofono. The result out of this discussion is:

- DUN: ConnMan should directly talk to BlueZ. There are too many issues
with having oFono in the middle. There is a strong relation ship between
PAN and DUN and ConnMan needs to be aware of it. Think about the kill
switch for bluetooth.

- org.ofono.modem.Property will get something like a ModemType. Possible
values are "hfp", "sap" and "hardware". ConnMan will take owner ship
(e.g. powering them up and set them online) for the "hardware" ones. The
other type of modems should be controlled by
an other component (e.g. dialer). I'm going to send a API extension
proposal on the ofone mailing list.

cheers,
daniel


--===============1789655335066143292==--

