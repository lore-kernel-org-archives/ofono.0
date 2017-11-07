Content-Type: multipart/mixed; boundary="===============3722477376899602594=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] gemalto: add PIN retries support in driver
Date: Tue, 07 Nov 2017 09:59:01 -0600
Message-ID: <90cf4d2d-6b79-5e34-bc05-2cb51760652b@gmail.com>
In-Reply-To: <1510048390-13428-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3722477376899602594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

On 11/07/2017 03:53 AM, Gabriel Lucas wrote:
> In SimManager, the Retries property isn't used for gemalto modems.
> The at command AT^SPIC is used to get the remaining retries left
> for the current required password type.
> =

> This commit adds the implementation in the SIM driver of the retries
> queries.
> ---
>   drivers/atmodem/sim.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> =


Applied, thanks.

Regards,
-Denis


--===============3722477376899602594==--

