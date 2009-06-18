Content-Type: multipart/mixed; boundary="===============9176306572438204012=="
MIME-Version: 1.0
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH] Use GET RESPONSE sim command to retrieve EF length.
Date: Thu, 18 Jun 2009 10:17:34 +0200
Message-ID: <20090618081734.GB5318@excalibur.local>
In-Reply-To: <1245296668-15210-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9176306572438204012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello.

On Thu, 2009-06-18 at 05:44, Andrzej Zaborowski wrote:
> =

> modem sends some command between SELECT and the GET RESPONSE.  These
> modems don't support AT+CSIM either in case we wanted to manually send
> the SELECT and the GET RESPONSE.

It does since GSM fw version Moko9-Beta2. Current is Moko11. You may want to
update the firmware if you like to test it with CSIM.

http://people.openmoko.org/joerg/calypso_moko_FW/all_version__CHANGELOG.txt
http://wiki.openmoko.org/wiki/GSM/Flashing

regards
Stefan Schmidt

--===============9176306572438204012==--

