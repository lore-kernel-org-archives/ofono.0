Content-Type: multipart/mixed; boundary="===============2893122769350832616=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: problem sim status
Date: Thu, 27 Mar 2014 15:05:45 -0500
Message-ID: <53348499.30802@gmail.com>
In-Reply-To: <lh1s7i$pvm$1@ger.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2893122769350832616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On 03/27/2014 01:55 PM, Eric BOUXIROT wrote:
> hi,
> =

> i make an embedded platform with a 3G modem from Sierra Wireless (SL808x
> series).
> i have a problem with ofono (v1.14) that ask sim status too fast after
> modem added resulting in CME Error 14 (SIM busy).
> =

> is there a way to delay the sim status query (+CPIN) ??
> =


Try adding OFONO_VENDOR_SIERRA to the list of vendors that require CPIN?
retry logic.  See drivers/atmodem/sim.c:1256

Regards,
-Denis

--===============2893122769350832616==--

