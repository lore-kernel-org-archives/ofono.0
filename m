Content-Type: multipart/mixed; boundary="===============5878977281199764788=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 0/10] Unregister AT notifiers when removing drivers
Date: Fri, 13 Aug 2010 08:59:03 +0800
Message-ID: <33AB447FBD802F4E932063B962385B3528F0C1EB@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1281611083.12579.249.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5878977281199764788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Marcel Holtmann wrote:
> Hi Zhenhua,
> =

>> This series unregister AT notifiers in removing various AT modem
>> drivers when modem goes to offline mode. Please review them. =

> =

> just a heads up here that Denis and I talked about this. And we are
> going to fix this inside GAtChat in the background for you. Trying to
> fix this single handed in every atom driver is wrong.
> =

> This approach creates too much of a maintenance burden. And additional
> code complexity and memory footprint doing it this way. So we have to
> tackle it in a central place. And that is GAtChat.

Thanks for update. Yes. The fix by Denis looks smart and make sense to
me. By using fa?ade pattern, we don't require user to track
register/unregister of AT notifers any more.

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
Zhenhua

--===============5878977281199764788==--

