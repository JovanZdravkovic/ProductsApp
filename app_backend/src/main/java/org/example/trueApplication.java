package org.example;

import io.dropwizard.Application;
import io.dropwizard.configuration.EnvironmentVariableSubstitutor;
import io.dropwizard.configuration.SubstitutingSourceProvider;
import io.dropwizard.db.DataSourceFactory;
import io.dropwizard.jdbi3.JdbiFactory;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.example.resources.ProductResource;
import org.example.services.ProductService;
import org.jdbi.v3.core.Jdbi;

public class trueApplication extends Application<trueConfiguration> {

    public static void main(final String[] args) throws Exception {
        new trueApplication().run(args);
    }

    @Override
    public String getName() {
        return "product-application";
    }

    @Override
    public void initialize(final Bootstrap<trueConfiguration> bootstrap) {
    }

    @Override
    public void run(final trueConfiguration configuration,
                    final Environment environment) {
        final JdbiFactory factory = new JdbiFactory();
        final Jdbi jdbi = factory.build(environment, configuration.getDataSourceFactory(), "postgresql");
        ProductResource productResource = new ProductResource(new ProductService(jdbi));
        environment.jersey().register(productResource);
    }

}
