Content-Type: multipart/mixed; boundary="===============8961742626529669313=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmi: Fix Secondary DNS overwriting Primary DNS
Date: Tue, 11 Dec 2018 14:15:30 -0600
Message-ID: <cb9f2766-9dec-8007-e037-9512ee7d042b@gmail.com>
In-Reply-To: <20181211195827.11907-1-pespin@sysmocom.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8961742626529669313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pau,

On 12/11/2018 01:58 PM, Pau Espin Pedrol wrote:
> inet_ntoa was called twice in a row and as a result both primay and
> secondary DNS were pointing to same static buffer containing last
> value (secondary DNS).
> =

> As a result, ofono always advertised the secondary DNS twice through
> DBus ConnectionContext.GetProperties 'DomainNameServers'.
> =

> Related: https://osmocom.org/issues/3031
> ---
>   drivers/qmimodem/gprs-context.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

Regards,
-Denis

--===============8961742626529669313==--

