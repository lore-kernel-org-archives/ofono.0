Content-Type: multipart/mixed; boundary="===============4976000717695065288=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Telit HE910 general fixes for gprs, sms and voicecall
Date: Mon, 09 Mar 2015 20:54:28 -0500
Message-ID: <54FE4ED4.2040904@gmail.com>
In-Reply-To: <222E70FA67D72A4FB8EEDF5AF01724ACC99A74@BGSMSX102.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4976000717695065288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ram,

Please don't top post on this mailing list.  Your answers should be inlined.

http://en.wikipedia.org/wiki/Posting_style#Top-posting

On 03/09/2015 07:21 AM, Kallumari Nagaraja Rao, RammohanX wrote:
> Guys,
>
> I am able to connect to the cellular network now.
>
> I killed a process pppd which was also using the ttyACM0 port.
>

Please make sure that no other modem management software is active. =

oFono requires exclusive access to all tty ports associated with the =

modem hardware.

So if you're running NetworkManager, ModemManager, pppd, etc, these must =

be stopped or configured to ignore the modem hardware you're trying to =

use with oFono.

> However, I will have to try out more than 1 time the following process,
>
> ofonod -> enable-modem -> activate-context
>
> for every second time it works, no idea yet on the reason.

Regards,
-Denis

--===============4976000717695065288==--

