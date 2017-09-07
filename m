Content-Type: multipart/mixed; boundary="===============8971857649947704542=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH][v2 1/2] voicecall,
 common: move call_status_to_string() to common
Date: Thu, 07 Sep 2017 17:30:09 -0500
Message-ID: <c4f24919-ae19-3cfc-fd8d-f94293e3fb64@gmail.com>
In-Reply-To: <20170907222733.26345-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8971857649947704542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 09/07/2017 05:27 PM, Alexander Couzens wrote:
> call_status_to_string() is useful for debug output.
> Change signature to contain enum call_status
> Replace default case to get compiler warning when new enums added
> ---
>   src/common.c    | 22 ++++++++++++++++++++++
>   src/common.h    |  1 +
>   src/voicecall.c | 20 --------------------
>   3 files changed, 23 insertions(+), 20 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis


--===============8971857649947704542==--

