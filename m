Content-Type: multipart/mixed; boundary="===============7868633310675220138=="
MIME-Version: 1.0
From: Remi.Denis-Courmont@nokia.com
Subject: Re: ConnectionContext creation for LTE PDN Connection.
Date: Tue, 30 Nov 2010 09:08:33 +0100
Message-ID: <1291104513.14343.11.camel@Nokia-N900-51-1>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7868633310675220138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

----- Message d'origine -----
> why would bringing an interface up interfere? We are doing this right
> now. Just the IP assignment is done by ConnMan, but the interface
> up/down status is controlled by oFono or even BlueZ in case of
> Bluetooth.

Logically whoever sets the IP parameters should bring the interface adminis=
tratively up. This is layer 3.

oFono does layer 2. It should either create/remove the interface and/or pla=
y with the dormant and/or carrier flags.

-- =

R=C3=A9mi
--===============7868633310675220138==--

