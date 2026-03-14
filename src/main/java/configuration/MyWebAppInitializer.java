//only once it will run in the start

package configuration;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class MyWebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{ AppConfig.class }; // Hibernate / service beans
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{ WebMvcConfig.class }; // MVC controllers, view resolver
    }

    @Override
    protected String[] getServletMappings() {
        return new String[]{ "/" }; // handle all URLs
    }
}