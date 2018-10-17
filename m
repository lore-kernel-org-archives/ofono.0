Content-Type: multipart/mixed; boundary="===============6971972997956768670=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 1/2] Gemalto: voicecall atom
Date: Wed, 17 Oct 2018 21:41:35 +0200
Message-ID: <cfb47359-7dc5-1cd9-8a66-46a362c508ad@norrbonn.se>
In-Reply-To: <20181017171037.14324-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6971972997956768670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,


On 17/10/18 19:10, Giacinto Cifelli wrote:
> Added voicecall atom specific for Gemalto modems.
> This atom uses the URC ^SLCC to monitor the call status, as well as
> incoming calls.
> Note the use in the atom of the variable GemaltoVtsQuotes: this is
> needed to support future modules, as of today not yet available in the
> plugin.
> ---
>   Makefile.am                         | 3 ++-
>   drivers/gemaltomodem/gemaltomodem.c | 3 +++
>   drivers/gemaltomodem/gemaltomodem.h | 5 +++++
>   3 files changed, 10 insertions(+), 1 deletion(-)

What happened here?  You seem to have lost voicecall.c...

/Jonas

--===============6971972997956768670==--

