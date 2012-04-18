Content-Type: multipart/mixed; boundary="===============5203532228245709419=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 0/2] Tweak at_util_sim_state_query_new() function
Date: Wed, 18 Apr 2012 12:06:30 +0200
Message-ID: <4F8E9226.403@linux.intel.com>
In-Reply-To: <1334674104-30039-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5203532228245709419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 17/04/2012 16:48, Guillaume Zajac wrote:
> Hi all,
>
> First patch improves at_util_sim_state_query_new() function.
> A user data destroyer can be now specifed.
> Second is just updating the plugins that are using this function.
>
> Kind regards,
> Guillaume
>
> Guillaume Zajac (2):
>    atutil: Add destroyer in at_util_sim_state_query_new prototype
>    plugins: Update new at_util_sim_state_query_new() prototype use
>
>   drivers/atmodem/atutil.c |    8 +++++++-
>   drivers/atmodem/atutil.h |    3 ++-
>   plugins/alcatel.c        |    3 ++-
>   plugins/mbm.c            |    2 +-
>   plugins/samsung.c        |    3 ++-
>   plugins/speedup.c        |    3 ++-
>   plugins/zte.c            |    3 ++-
>   7 files changed, 18 insertions(+), 7 deletions(-)
>

I need to integrate these patches with SIM polling patch to be more clear.
I will send a new version.

Kind regards,
Guillaume

--===============5203532228245709419==--

