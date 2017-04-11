Content-Type: multipart/mixed; boundary="===============2689681863254592626=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] qmi: NAS definitions adjustment
Date: Tue, 11 Apr 2017 10:23:20 -0500
Message-ID: <d7461f7f-dd82-ee69-1a9e-b32b410dc3c9@gmail.com>
In-Reply-To: <20170411081818.19544-2-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2689681863254592626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/11/2017 03:18 AM, Jonas Bonn wrote:
> Calling the ps_state/cs_state alternatives *ATTACH_STATUS* was confusing
> because there is also a status field in the *serving_system structure.
> This patch does a minor rename and adds the appropriate definitions for
> the status field.
> ---
>  drivers/qmimodem/gprs.c |  2 +-
>  drivers/qmimodem/nas.h  | 14 +++++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============2689681863254592626==--

