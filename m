Content-Type: multipart/mixed; boundary="===============6932055128737352626=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Read messages left over in ME storage on startup.
Date: Tue, 08 Sep 2009 16:56:18 -0500
Message-ID: <200909081656.18473.denkenz@gmail.com>
In-Reply-To: <fb249edb0909042216j1cfcad7bmab81195fd68e6f4e@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6932055128737352626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > It might be worth to scan both ME & SM stores.  Especially since MT
> > literally means combined SM + ME store.
>
> We already do this, in at_cmgl_done after listing ME_STORE we repeat
> the commands for SM_STORE.
>

Yep I missed this part.  Looks good to me.

Patch has been applied.

Regards,
-Denis

--===============6932055128737352626==--

