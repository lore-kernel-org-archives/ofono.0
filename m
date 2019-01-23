Content-Type: multipart/mixed; boundary="===============0903078290867341386=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Wed, 23 Jan 2019 17:47:19 -0600
Message-ID: <a32339ab-2416-b000-8294-b4925980875f@gmail.com>
In-Reply-To: <1547620637-7445-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0903078290867341386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 01/16/2019 12:37 AM, Nandini Rebello wrote:
> Adding SIM PIN caching feature to oFono. oFono now caches the SIM PIN1 ty=
pe
> against the ICCID throughout its lifetime in a link list and enters
> implicitly upon modem reset/crash.
> =

> Violates 3GPP spec 21.111, section 5.3 - User Data stored in ME. Helps
> in user experience by not barring out cellular services unless pin is ent=
ered
> manually.
> =

> Handles cases of incorrect pin and sim pin changed externally.
> Clear cached PIN incase modem disabled manually and selectively when
> sim is removed.
> =

> Seperate 'pin_cache_enter_cb' added without dbus calls to handle implict =
entering of
> cached pin.
> =

> Adding to all modems by default.
> ---
>   src/sim.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 111 insertions(+)
> =


I went ahead and applied this patch after minor style cleanups.  I also =

renamed void ofono_sim_clear_cached_pins(struct ofono_sim *sim) to
__ofono_sim... and put it in ofono.h.

This means that your other patch was unnecessary.  In the future, please =

send all these as a series.

Additionally, I pushed out commit =

0c1685a205570f407fb8dcdb5ccb75de21a96c7b.  Please make sure it is =

correct and there are no other memory leaks lurking.

Regards,
-Denis

--===============0903078290867341386==--

