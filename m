Content-Type: multipart/mixed; boundary="===============5867771084406400839=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 5/6] Support for concatenated SMS status report.
Date: Fri, 04 Jun 2010 17:04:33 -0500
Message-ID: <201006041704.34509.denkenz@gmail.com>
In-Reply-To: <1275650257-30593-6-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5867771084406400839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> ---
>  include/history.h |    2 +
>  src/sms.c         |   67 ++++++++++++++++++++----
>  src/smsutil.c     |  152
>  +++++++++++++++++++++++++++++++++++++++++++++++++++++ src/smsutil.h     =

| =

>   32 +++++++++++

Please break this up into at least 3 patches:
- include/history api change
- smsutil changes
- sms core atom changes

Ideally I'd also like to see a unit test for smsutil parts in the series.
> +void add_pending_status_report(GSList **pending_status_reports, const int
>  mr, +					const unsigned int msg_id,
> +					const struct sms_address *receiver);
> +
> +void free_pending_status_report(struct pending_status_report
>  *status_report, +				GSList **pending_status_reports);
> +
> +enum ofono_history_sms_status update_pending_status_report_mr_number(
> +		GSList **pending_status_reports, const guint8 mr,
> +		const struct sms_address *receiver,
> +		const enum sms_status_report_result status_report_result,
> +		unsigned int *relating_msg_id);
> +

So my first suggestion here is to make the status report assembly into its =
own =

class.  This way you can mess around with the internal data structures and =

optimize them later if needed without breaking the rest of the code.

This is also where unit tests come in. Once you have something working, you =

can optimize and make sure things still work... without affecting the rest =
of =

the code.

I suggest thinking about the data structure use some more.  In particular, =

using a list of struct mr_numbers is very inefficient.  Using a pair of bit=
maps =

for mr numbers (which can only be 0..255) would be way more efficient and =

probably would make the code much easier to write.

Consider if making multi-level data structures would increase efficiency.  =
E.g. =

Hastable[destination_address] =3D list of structures mapping between messag=
e id =

and message references.  Or anything else efficient you can come up with.

Having said that, don't over-complicate it in the beginning.  Having someth=
ing =

good enough and working is better.

For the object interface I suggest something like:

struct status_report_assembly;

- Creates a new assembly object, and populates pending status reports from =
the =

imsi-keyed store.  If imsi is NULL, no status reports are saved or loaded f=
rom =

disk.  This is useful for pseudo-modems:
struct status_report_assembly *status_report_assembly_new(const char *imsi);

- Frees the assembly:
void status_report_assembly_free(struct status_report_assembly *assembly);

- Just a thought, but some networks simply don't support status reports, so=
 we =

need to expire status reports for messages that have lived past their valid=
ity =

period:
void status_report_assembly_expire(struct status_report_assembly *assembly,
								time_t before, (GFunc) foreach_func,
								gpointer data);

- Add a status report to the assembly and return whether this resulted in a =

message being delivered / not:
gboolean status_report_assembly_report(struct status_report_assembly =

*assembly,
										const struct sms *status_report,
										unsigned int *msg_id,
										enum sms_st *status)

- Add a message fragment to the assembly for tracking:
void status_report_assembly_add_fragment(struct status_report_assembly =

*assembly,
										unsigned int *msg_id,
										struct sms_address *to,
										unsigned char mr,
										time_t expiration);

Feel free to modify the above as needed, this is just something I came up w=
ith =

while reviewing your patch.

Regards,
-Denis

--===============5867771084406400839==--

