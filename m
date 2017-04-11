Content-Type: multipart/mixed; boundary="===============5100498175582490047=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to test ofono for MediaTek Modem and Qualcomm Modem
Date: Tue, 11 Apr 2017 12:45:03 -0500
Message-ID: <2c4fdfc6-01c3-a51c-afce-9a23899d6649@gmail.com>
In-Reply-To: <CAOLU1cTd4Mj=E0n4svet=HgyFV_MA7AjUzeRRoCCU2uHgeD2QA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5100498175582490047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rohit,

Please do not top-post on this mailing list.

> Isn't the master branch at
> https://git.kernel.org/pub/scm/network/ofono/ofono.git/ supposed to
> support Android RILD based modems ? My understanding says even MediaTek
> modems should be covered under this. The code at location

oFono upstream has support for ril based modems yes.  It has only been =

tested with Intel SoFiA devices.  There are no guarantees that other =

modems work.

> https://github.com/rilmodem/ofono <https://github.com/rilmodem/ofono> is
> based on ofono version 1.12 while the latest ofono code version is 1.19.

Canonical (and Jolla, and maybe other companies) maintain their own =

forks of oFono for use with their distribution / devices / modems / =

firmware combinations.  However, the bulk of the rilmodem driver should =

be the same, with differences mostly attributed to various =

firmware/manufacturer specific behavior.

> I don't want to work on multiple versions of ofono. Could you elaborate
> on why such a difference ? Not sure what special support is present at
> location
> https://github.com/rilmodem/ofono <https://github.com/rilmodem/ofono>
> which is not present on master branch of ofono (Official). It would be
> great if you could put some light onto this.
>

Unfortunately, even with RIL defining 'some sort of standard', the =

behavior varies widely between firmware/manufacturer.  Many operations =

are accomplished via manufacturer specific RIL extensions, or even by =

hacking the Android telephony services that sit above rild.  Canonical =

guys (e.g. Alfonso) might have some experience with MediaTek devices. =

So be nice to them ;), but there are no guarantees that their modem / =

firmware / vendor-ril is the same as yours.

The mtk/mtk2 driver that Alfonso mentioned is not in the official =

upstream branch, nor likely to ever be.  You will need to perform your =

own due diligence to understand the implications for your particular =

project.

Regards,
-Denis


--===============5100498175582490047==--

