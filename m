Content-Type: multipart/mixed; boundary="===============5783876518990880319=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH v7 6/7] gemalto/lte: Gemalto vendor lte atom
Date: Sat, 20 Oct 2018 18:24:45 +0200
Message-ID: <CAKSBH7GBW5BpWXqui2W3=qv5t2gfYhq8-4OUo0uaBq6m3K0ifg@mail.gmail.com>
In-Reply-To: <ec6a85f6-f138-f3d3-6171-3237a59e2900@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5783876518990880319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
>
> I still don't get this explanation.  You have a gemalto specific
> function, which is being passed the CID directly by the caller.  Why is
> there weird logic here to mess with the CID, just have the caller pass
> in the proper CID directly.
>
> Also note that cid 1 and 3 are by default valid CIDs for context
> activations.  So your 'default attach' profile can be overridden by the
> core at any time.  So you may want to address this by setting the cid
> range appropriately.

The function is to be called also from gprs-context, therefore passing
0 it knows it has to check whether it has to use 1 or 3 or something
else.
The cid-ranges are set in the plugin, also because I cannot use
AT+CGDCONT=3D? with all models.
There are some that return an answer to this command like (1-16),
which is ok, but then we have some that return (1,2,3,4,5,6), and
still other (1-10,17)...

>
> Regards,
> -Denis

Regards,
Giacinto

--===============5783876518990880319==--

