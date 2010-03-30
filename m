Content-Type: multipart/mixed; boundary="===============3925832026710738228=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 09/10] Adjust the sequence of icon identifier structure
Date: Tue, 30 Mar 2010 10:04:48 -0500
Message-ID: <201003301004.48442.denkenz@gmail.com>
In-Reply-To: <1269935857-4234-9-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3925832026710738228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> ---
>  src/stkutil.h |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)

Please sanity check your patches, while applying I got this:

Applying: Add parser for items next action indicator objects
Applying: Adjust the sequence of comprehension tlv structures
Applying: Add parser for event list objects
Applying: Add parser for cause objects
Applying: Add parser for location status objects
Applying: Add parser for transaction identifier objects
Applying: Add parser for call control requested action objects
Applying: Add enum for icon qualifier
Applying: Adjust the sequence of icon identifier structure
/home/denkenz/ofono-master/.git/rebase-apply/patch:38: trailing whitespace.
/* =

fatal: 1 line adds whitespace errors.
Patch failed at 0009 Adjust the sequence of icon identifier structure
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

Use
[apply]
        whitespace =3D error

in your git config and apply locally to make sure they do so cleanly.

Regards,
-Denis

--===============3925832026710738228==--

