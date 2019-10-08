Content-Type: multipart/mixed; boundary="===============3655035348220429242=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 1/2] gatmux: take reference to mux object while
 processing incoming data
Date: Tue, 08 Oct 2019 14:47:38 -0500
Message-ID: <4a5ca949-0c47-5b89-d96b-e91885bff624@gmail.com>
In-Reply-To: <20191008184441.7410-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3655035348220429242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 10/8/19 1:44 PM, Martin Hundeb=C3=B8ll wrote:
> When closing down a cmux object, the address sanitizer detects a
> use-after-free in gatmux.c (see below).
> =

> Avoid this by taking a reference to the mux object during the processing
> in received_data().
> =


Applied, thanks.

Regards,
-Denis

--===============3655035348220429242==--

