Content-Type: multipart/mixed; boundary="===============0316033567162901583=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [originated PATCH 0/2]
Date: Wed, 08 Sep 2010 21:18:14 -0500
Message-ID: <4C8843E6.5060106@gmail.com>
In-Reply-To: <1283785768-4509-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0316033567162901583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 09/06/2010 10:09 AM, Pekka.Pessi(a)nokia.com wrote:
> Hi all,
> =

> This patch adds the "Originated" property to the VoiceCall interface. It
> is used to determine if the call is originated from the mobile or not.

Just throwing ideas, but would 'string Direction' with possible values
"in" or "incoming" and "out" or "outgoing" be a bit clearer?

> =

> The originated information can be deducted from the call state assuming
> the client does follow the call states from the beqginning. However,
> after the call gets activated call states are common for the mobile
> originated and mobile terminated calls.

Out of curiosity, how exactly is this useful?

Regards,
-Denis

--===============0316033567162901583==--

