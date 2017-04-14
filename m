Content-Type: multipart/mixed; boundary="===============2523129446006466188=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH QMI LTE v2 05/13] gprs: set driver_attached when
 activating automatic contexts
Date: Fri, 14 Apr 2017 17:43:56 -0500
Message-ID: <78f7a3e5-a259-98f3-bb43-e0cf4fe59830@gmail.com>
In-Reply-To: <20170414213646.32066-6-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2523129446006466188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/14/2017 04:36 PM, Jonas Bonn wrote:
> The ofono_gprs_cid_activated attachment machinery cannot go through
> ofono_gprs_status_notify for getting the attached property set because
> that would result in the automatic contexts that were just set up
> being released.  As such, it needs to call gprs_set_attached_property
> manually.  Doing so, however, means that the driver_attached property
> never gets set, resulting in all contexts being released when the
> network transitions between registered states (roaming/non-roaming).
> ---
>  src/gprs.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Regards,
-Denis


--===============2523129446006466188==--

