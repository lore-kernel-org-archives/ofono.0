Content-Type: multipart/mixed; boundary="===============1414538196905161165=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Voice calls over qmi was Re: Incoming sms problem on Motorola
 Droid 4
Date: Mon, 14 May 2018 11:19:40 -0500
Message-ID: <a1e2e766-7b68-8bc7-493e-bf8fec5f24d0@gmail.com>
In-Reply-To: <20180512161842.7a68dc38@lazus.yip>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1414538196905161165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander, Joey,

On 05/12/2018 09:19 AM, Alexander Couzens wrote:
> Hi Joey,
> =

> nice to hear, somebody else is using it.
> =

> The voicecall driver needs to be refactored as Denis already pointed
> out on the mailinglist before it can go upstream.

If it wasn't clear from my earlier mail, I would like to see these =

patches upstreamed.  Do you guys have plans to do so?  I'm happy to =

review/help these along...

> =

> The original idea of the voice_generated.c/h files was to create a
> prototype how qmi generated files should look like and then write a
> code generator for it, as the other qmi related projects already do.

As you can tell we're not really sold on the whole code generation thing =

here :)  Can we simply stuff all structure definitions into voice.h and =

the parsers into qmiutils.[ch].

In the past we have parsed fairly complex TLV based objects using a =

common parsing function that took care of the various funny rules and =

corner cases.  Adding support for additional objects was then quite =

trivial.  See src/stkutil.[ch], start at 'parse_dataobj()'.  Perhaps =

this approach might be one for you to consider.

Regards,
-Denis

--===============1414538196905161165==--

