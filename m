Content-Type: multipart/mixed; boundary="===============7215183598991952906=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Polling CLCC error handling on Option modem (GTA04)
Date: Tue, 06 Mar 2012 10:13:58 -0600
Message-ID: <4F5637C6.6000708@gmail.com>
In-Reply-To: <201203071136.24508.psonek2@seznam.cz>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7215183598991952906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Radek,

On 03/07/2012 04:36 AM, Radek Polak wrote:
> On Monday 05 March 2012 20:26:29 Denis Kenzior wrote:
> =

>> You can always try ignoring CME ERROR 100 and re-try the CLCC poll.
>> Maybe the modem is in a transitional period (e.g. call being released)
>> and it can't answer the CLCC properly.  In other words, there's a bug
>> related to timing of call state changes & CLCC implementation in the
>> modem firmware.
> =

> Yes, it is definitely timing bug. Attached is patch that continues CLCC p=
olling =

> even after error assuming that CLCC will start working again. It works fi=
ne for =

> me (see log below). It would be nice to get this in ofono git.
> =


I pushed my own version of this patch that is a little bit more
paranoid.  git show ebac438d for more details.

Regards,
-Denis

--===============7215183598991952906==--

