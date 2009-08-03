Content-Type: multipart/mixed; boundary="===============5200240603852561404=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: ofono build error on ARM
Date: Mon, 03 Aug 2009 09:48:54 +0200
Message-ID: <9d3db6ff9cd187b6be7af38a1cbd1953@chewa.net>
In-Reply-To: <200908011856.54384.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5200240603852561404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Sat, 1 Aug 2009 18:56:54 +0300, "R=C3=A9mi Denis-Courmont" <remi@remla=
b.net>
wrote:
> As far as I understand, those warnings come from casting receive buffers
> into structure with higher-order alignment requirement  - with some of
> your competitors' CPU architectures anyway ;) Arguably, those are caused
> by kernel/libc headers, not Ofono. I will check on Monday if we can fix
> them by promoting the receive buffers to larger integer types, but it
might
> make the code worse.

Nope. The problem is that netlink is internally casting pointers to char*
for arithmetic operation, and then back to struct whatever. This confuses
gcc, even though it should be a non-issue at run-time.

-- =

R=C3=A9mi Denis-Courmont


--===============5200240603852561404==--

