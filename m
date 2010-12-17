Content-Type: multipart/mixed; boundary="===============0350544233276615480=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] call-forwarding: Read/Write cfis/cphs-cff
Date: Fri, 17 Dec 2010 17:16:05 -0600
Message-ID: <4D0BEF35.5000507@gmail.com>
In-Reply-To: <1292569471-20952-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0350544233276615480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 12/17/2010 01:04 AM, Jeevaka Badrappan wrote:
> ---
>  src/call-forwarding.c |  243 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 241 insertions(+), 2 deletions(-)
> =


So I applied this patch but refactored it very heavily afterward.  Can
you do review the changes and make sure you're OK with them?  Can you
also submit the needed records for phonesim, so we can get those tested
as well?

I still have one concern with cfis_record_id selection logic.  There are
a couple of possibilities we might not be handling correctly:

- if no EFcfis records contain proper MSP ids
- if EFcfis record has a valid MSP id, but is relevant to teleservices
besides voice.  We still potentially select this record, even though a
voice specific record might or might not exist.

Overall I think we need to test this feature quite a bit more...

Regards,
-Denis

--===============0350544233276615480==--

