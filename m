Content-Type: multipart/mixed; boundary="===============4218617625944432871=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] unit: add new test-rilmodem-sms
Date: Tue, 17 Nov 2015 21:28:20 -0600
Message-ID: <564BF054.2050101@gmail.com>
In-Reply-To: <1447811116-11970-2-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4218617625944432871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 11/17/2015 07:45 PM, Tony Espy wrote:
> ---
>   unit/rilmodem-test-server.c | 198 ++++++++++++++++++++++++++++++++
>   unit/rilmodem-test-server.h |  40 +++++++
>   unit/test-rilmodem-sms.c    | 267 +++++++++++++++++++++++++++++++++++++=
+++++++
>   3 files changed, 505 insertions(+)
>   create mode 100644 unit/rilmodem-test-server.c
>   create mode 100644 unit/rilmodem-test-server.h
>   create mode 100644 unit/test-rilmodem-sms.c
>

<snip>

> +void rilmodem_test_server_create(ConnectFunc connect,
> +				const struct rilmodem_test_data *test_data,
> +				void *data)
> +{
> +	GIOChannel *io;
> +	struct sockaddr_un addr;
> +	int retval;
> +
> +	g_assert(server_sk =3D=3D 0);
> +
> +	connect_func =3D connect;
> +	rtd =3D test_data;
> +
> +	server_sk =3D socket(AF_UNIX, SOCK_STREAM, 0);
> +	g_assert(server_sk);
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.sun_family =3D AF_UNIX;
> +	strncpy(addr.sun_path, RIL_SERVER_SOCK_PATH, sizeof(addr.sun_path) - 1);
> +
> +	/* Unlink any existing socket for this session */
> +	unlink(addr.sun_path);
> +
> +	retval =3D bind(server_sk, (struct sockaddr *) &addr, sizeof(addr));
> +	g_assert(retval >=3D 0);
> +
> +	retval =3D listen(server_sk, 0);
> +	g_assert(retval >=3D 0);
> +
> +	io =3D g_io_channel_unix_new(server_sk);
> +	g_assert(io !=3D NULL);
> +
> +	g_io_channel_set_close_on_unref(io, TRUE);
> +	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);

Not sure you really need the non-block flag for a socket you will call =

accept on once.  But okay.

> +
> +	g_io_add_watch_full(io,	G_PRIORITY_DEFAULT,
> +				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +				on_socket_connected, data, NULL);
> +
> +	g_io_channel_unref(io);
> +}

<snip>

> diff --git a/unit/test-rilmodem-sms.c b/unit/test-rilmodem-sms.c
> new file mode 100644
> index 0000000..0e3bff3
> --- /dev/null
> +++ b/unit/test-rilmodem-sms.c

<snip>

> +/* TODO: Did these get removed upstream? */
> +

Whats this about?

> +/* Declarations && Re-implementations of core functions. */
> +void ril_sms_exit(void);
> +void ril_sms_init(void);
> +
> +struct ofono_sms {
> +	void *driver_data;
> +};
> +
> +struct ofono_sms *ofono_sms_create(struct ofono_modem *modem,
> +					unsigned int vendor,
> +					const char *driver,
> +					void *data)
> +{
> +	struct rilmodem_sms_data *rsd =3D data;
> +	struct ofono_sms *sms =3D g_new0(struct ofono_sms, 1);
> +	int retval;
> +
> +	retval =3D smsdriver->probe(sms, OFONO_RIL_VENDOR_AOSP, rsd->ril);
> +	g_assert(retval =3D=3D 0);
> +
> +	return sms;
> +}
> +
> +int ofono_sms_driver_register(const struct ofono_sms_driver *d)
> +{
> +	if (smsdriver =3D=3D NULL)
> +		smsdriver =3D d;
> +
> +	return 0;
> +}
> +
> +void ofono_sms_set_data(struct ofono_sms *sms, void *data)
> +{
> +	sms->driver_data =3D data;
> +}
> +
> +void *ofono_sms_get_data(struct ofono_sms *sms)
> +{
> +	return sms->driver_data;
> +}
> +
> +void ofono_sms_register(struct ofono_sms *sms)
> +{
> +	;

Can we just make these empty functions instead of the ';' thing?

> +}
> +
> +void ofono_sms_driver_unregister(const struct ofono_sms_driver *d)
> +{
> +	;
> +}
> +
> +void ofono_sms_deliver_notify(struct ofono_sms *sms, const unsigned char=
 *pdu,
> +				int len, int tpdu_len)
> +{
> +	;
> +}
> +
> +void ofono_sms_status_notify(struct ofono_sms *sms, const unsigned char =
*pdu,
> +				int len, int tpdu_len)
> +{
> +	;
> +}
> +
> +static void server_connect_cb(gpointer data)
> +{
> +	struct rilmodem_sms_data *rsd =3D data;
> +	const struct sms_data *sd =3D rsd->test_data;
> +
> +	/* This causes local impl of _create() to call driver's probe func. */
> +	rsd->sms =3D ofono_sms_create(NULL, OFONO_RIL_VENDOR_AOSP,
> +							"rilmodem", rsd);
> +
> +	/* add_idle doesn't work, read blocks main loop!!! */
> +	g_assert(sd->start_func(rsd) =3D=3D FALSE);
> +}
> +
> +#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
> +

Can we keep the number of these #if conditions to a minimum?  Would it =

suffice to simply #ifdef this out in main.c?  Or better yet, disable =

from the build completely.

> +/*
> + * This unit test:
> + *  - does some test data setup
> + *  - configures a dummy server socket
> + *  - creates a new gril client instance
> + *    - triggers a connect to the dummy
> + *      server socket
> + *  - starts a mainloop
> + */
> +static void test_sms_func(gconstpointer data)
> +{
> +	const struct sms_data *sd =3D data;
> +	struct rilmodem_sms_data *rsd;
> +
> +	ril_sms_init();
> +
> +	rsd =3D g_new0(struct rilmodem_sms_data, 1);
> +
> +	rsd->test_data =3D sd;
> +
> +	rilmodem_test_server_create(&server_connect_cb, &sd->rtd, rsd);
> +
> +	rsd->ril =3D g_ril_new(RIL_SERVER_SOCK_PATH, OFONO_RIL_VENDOR_AOSP);
> +	g_assert(rsd->ril !=3D NULL);
> +
> +	mainloop =3D g_main_loop_new(NULL, FALSE);
> +
> +	g_main_loop_run(mainloop);
> +	g_main_loop_unref(mainloop);
> +
> +	smsdriver->remove(rsd->sms);
> +	g_ril_unref(rsd->ril);
> +	g_free(rsd);
> +
> +	rilmodem_test_server_close();
> +
> +	ril_sms_exit();
> +}
> +
> +#endif
> +
> +int main(int argc, char **argv)
> +{
> +	g_test_init(&argc, &argv, NULL);
> +
> +/*
> + * As all our architectures are little-endian except for
> + * PowerPC, and the Binder wire-format differs slightly
> + * depending on endian-ness, the following guards against test
> + * failures when run on PowerPC.
> + */
> +#if BYTE_ORDER =3D=3D LITTLE_ENDIAN
> +	g_test_add_data_func("/testrilmodemsms/sca_query/valid/1",
> +					&testdata_sca_query_valid_1,
> +					test_sms_func);
> +
> +#endif
> +	return g_test_run();
> +}
>

Regards,
-Denis

--===============4218617625944432871==--

