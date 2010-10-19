Content-Type: multipart/mixed; boundary="===============7471050712187941639=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Call Barring and MMI Supplementary Service codes
Date: Tue, 19 Oct 2010 18:30:19 +0300
Message-ID: <AANLkTinR2KBpu+Qs4Y-Tgu1AKCZFFKzAndzZkzFYv3T+@mail.gmail.com>
In-Reply-To: <4CBDB535.7040708@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7471050712187941639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/10/19 Denis Kenzior <denkenz@gmail.com>:
> So let me repeat what you said in my own words. =C2=A0The lowlevel regist=
er
> message has these variations:
>
> - All data circuit sync
> - All sync services
>
> - All data circuit async
> - All async services
>
> In both cases they actually refer to the same set of bearer services.

> So sending one vs the other makes no difference. =C2=A0So instead of
> deprecating the 'all sync' and 'all async' versions of the low level
> register messages the spec still expects us to send them for whatever
> reason.

There is also a set of PLMN-specific services. I suppose it is up to
network to decide which are sync or async and which involve data
circuits... There are some traces in Nokia modems indicating even that
they have been actually used at some point.

-- =

Pekka.Pessi mail at nokia.com

--===============7471050712187941639==--

