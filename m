Content-Type: multipart/mixed; boundary="===============2198757698412314236=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Thu, 03 Jan 2019 12:08:51 +0100
Message-ID: <CAKSBH7F0iS1CswVbMziQb5aQjNFa+3T7zJrkPpjdoHLBUwRB-A@mail.gmail.com>
In-Reply-To: <1546513282-13190-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2198757698412314236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nandini,

On Thu, Jan 3, 2019 at 12:01 PM Nandini Rebello
<nandini.rebello@intel.com> wrote:
>
> Adding SIM PIN caching feature to oFono. oFono now caches the SIM PIN1 ty=
pe
> against the ICCID throughout its lifetime in a link list and enters
> implicitly upon modem reset/crash.
>
> Violates 3GPP spec 21.111, section 5.3 - User Data stored in ME. Helps
> in user experience by not barring out cellular services unless pin is ent=
ered
> manually.
>
> Handles cases of incorrect pin and sim pin changed externally.
> Clears all cached PINs incase modem disabled manually and selectively when
> sim is removed.
>
> Adding to all modems by default.

Since it can cause losing certification, it would be better to have a
property CachePIN1, disabled by default, and the application can
select whether to go against the standard or not.

Regards,
Giacinto

--===============2198757698412314236==--

