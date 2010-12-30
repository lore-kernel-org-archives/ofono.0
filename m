Content-Type: multipart/mixed; boundary="===============7553577428627529725=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: unsolicited multiline result
Date: Thu, 30 Dec 2010 11:03:16 -0600
Message-ID: <4D1CBB54.8040103@gmail.com>
In-Reply-To: <1293728155-1781-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7553577428627529725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 12/30/2010 10:55 AM, Petteri Tikander wrote:
> =

> This patch is for handling multiline unsolicited result-codes.
> So state-machine used for handling result-bytes (gsmv1_feed) is set to th=
e multiline-response
> state. Otherwise next lines from the result-buffer are not handled correc=
tly,
> and response-handling will get stuck.

I've never heard of multiline-unsolicited result codes.  Unsolicited
responses are always prefixed and suffixed by a crlf.  Are you trying to
combine the +CEN query and +CEN unsolicited responses into a single
parser by any chance?

> =

> In the other hand, this correction keeps result-handling still unchanged.
> So single line is notified to the upper level (atoms) at a time, not all =
lines of the result.
> For instance: network-emergency numbers cannot be collect to the one sing=
le notification yet.

Regards,
-Denis

--===============7553577428627529725==--

