Content-Type: multipart/mixed; boundary="===============8656111595346464946=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 12/12] doc: Add ReportChanged signal description
Date: Tue, 28 Aug 2012 09:29:52 -0500
Message-ID: <503CD5E0.7030701@gmail.com>
In-Reply-To: <1345813571-15775-13-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8656111595346464946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

On 08/24/2012 08:06 AM, Ronald Tessier wrote:
> ---
>   doc/message-api.txt |    7 +++++++
>   1 file changed, 7 insertions(+)
>

Please order any D-Bus API changes before the D-Bus API implementations. =

  E.g. this patch should be #10 in your series.

> diff --git a/doc/message-api.txt b/doc/message-api.txt
> index 2922e5d..274bb98 100644
> --- a/doc/message-api.txt
> +++ b/doc/message-api.txt
> @@ -31,6 +31,13 @@ Signals		PropertyChanged(string name, variant value)
>   			The only expected property change is for the
>   			message status.
>
> +		ReportChanged(string type, variant recipient, variant status)
> +
> +			Signal that is sent when a report has been received and
> +			processed. It contains the type of the report
> +			("delivery_report" or other), the recipient concerned
> +			and its new status.
> +

Why are we not simply changing the 'Status' to delivered/expired, etc?

>   Properties	string Status [readonly]
>
>   			The status of the message.  Possible values are

Regards,
-Denis

--===============8656111595346464946==--

