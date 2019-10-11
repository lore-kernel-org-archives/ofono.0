Content-Type: multipart/mixed; boundary="===============7772414638669781632=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 1/2] quectel: rework sim detection
Date: Fri, 11 Oct 2019 12:12:25 -0500
Message-ID: <001e13a9-76f2-5e03-3bd4-906857d55de6@gmail.com>
In-Reply-To: <20191007213959.20110-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7772414638669781632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 10/7/19 4:39 PM, Martin Hundeb=C3=B8ll wrote:
> Use at_util_sim_state_query_new() to query the sim inserted state. Once
> that returns, the locked state is queried by issuing a AT+CPIN? command.
> =

> If not locked, a timer is started to query the quectel init status of
> the sim. Once the init status is ready, the sim atom is created, and the
> modem is set to powered, and the sim is signaled both inserted, and
> initialized.
> =

> If locked, the modem is set to powered, and the sim atom is created.
> This allows users to enter the pin to unlock the sim. Once the sim is
> unlocked, a +CPIN: READY indication is caught to query the quectel
> init status. Once the init status is ready, the sim is signaled
> initialized.
> =

> All the above is needed, because the modem indicated +CPIN: READY before
> the sim is really ready. The only way to be certain, is to wait for the
> quectel init status to be ready. Even signaling the sim inserted
> prematurely can cause to modem to hang during the initial AT+CRSM
> commands.
> ---
> =

> Changes since v2:
>   * None
> =


Applied, thanks.

Regards,
-Denis

--===============7772414638669781632==--

