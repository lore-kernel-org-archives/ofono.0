Content-Type: multipart/mixed; boundary="===============6087411713740165899=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCHv2] quectel: swap cmuxed ports
Date: Mon, 02 Sep 2019 23:22:00 +0200
Message-ID: <fffd986e-774a-0fbd-dde8-bd142f04f41f@geanix.com>
In-Reply-To: <20190902211759.61961-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6087411713740165899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02/09/2019 23.17, Martin Hundeb=C3=B8ll wrote:
> According to the manual, when using CMUX on the UC15, it outputs
> unsolicited indications on port 2 (i.e. /dev/gsmtty2), so the quectel
> plugin must use this when registering for such.

Sorry, this should have been a separate patch instead of a v2 reply to =

the sim patch.

// martin

--===============6087411713740165899==--

