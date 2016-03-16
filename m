Content-Type: multipart/mixed; boundary="===============0374751861187309178=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/11] plugins/udevng: support different interface strings
 to detect TOBY series
Date: Wed, 16 Mar 2016 13:00:20 -0500
Message-ID: <56E99F34.4000100@gmail.com>
In-Reply-To: <1457970664-20782-2-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0374751861187309178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dongsu,

On 03/14/2016 10:50 AM, Dragos Tatulea wrote:
> From: Dongsu Park <dongsu@endocode.com>
>
> Each modem expresses their interfaces with its own interface string,
> which is composed of 3 different USB attributes:
> "bInterfaceClass/bInterfaceSubClass/bInterfaceProtocol".
> While the old models like LISA support only "2/2/1" for modem
> interfaces, TOBY-L2 also supports an unique string for NetworkInterface
> for each profile.
>
> * low-medium throughput profile : 2/6/0
> * fairly backward-compatible profile : 10/0/0
> * high throughput profile : 224/1/3
>
> Besides the condition for checking NULL for mdm/aux/net should be relaxed
> a little bit.
> ---
>   plugins/udevng.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============0374751861187309178==--

