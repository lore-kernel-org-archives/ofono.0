Content-Type: multipart/mixed; boundary="===============2512187804151477758=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv4] simfs: read files from specific AID's
Date: Mon, 06 Nov 2017 16:12:40 -0600
Message-ID: <5a6111ad-38e1-31d5-756d-4d25265d9da2@gmail.com>
In-Reply-To: <1510002458-752-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2512187804151477758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/06/2017 03:07 PM, James Prestwood wrote:
> The simfs atom could not read EF's that did not exist on the
> 'default' ADF directory. This implements a new way to read EF's
> that exist on a given AID. A new fs object/context can be
> initialized for a given AID. Using this fs context with
> the existing read file API will read from that AID rather than
> the default ADF.
> ---
>   src/simfs.c | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
-------
>   src/simfs.h |   3 ++
>   2 files changed, 155 insertions(+), 18 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============2512187804151477758==--

